Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA9D8053F2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbjLEMP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344974AbjLEMPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:15:51 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53ABD10DD;
        Tue,  5 Dec 2023 04:15:46 -0800 (PST)
Received: from localhost (unknown [46.242.8.170])
        by mail.ispras.ru (Postfix) with ESMTPSA id 82FEF40F1DE8;
        Tue,  5 Dec 2023 12:15:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 82FEF40F1DE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1701778543;
        bh=H7a/FeUhwOKqH2yi6Ii8EYVnQ0T26j0ybsDcPTJaRrU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GPRU4I6ZiaDjYAtv4DcyQ22znV9W92uPHlY70xORi9MjOPLQ5nt/GxUmU6Z9/l3+c
         QwdPNACxtUuTpcb2/GJBgldM2fQi/BBDQohqGPJffXlpp8cW9rNp5X2II+QaHbKaqa
         bT0Hmb8KIvnjtF18X14wNwhP/RNYS3wQgqb63vcc=
Date:   Tue, 5 Dec 2023 15:15:43 +0300
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, v9fs@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] net: 9p: avoid freeing uninit memory in p9pdu_vreadf
Message-ID: <2974507b-57fa-4c9b-a036-055dbf55f6a4-pchelkin@ispras.ru>
References: <ZW7oQ1KPWTbiGSzL@codewreck.org>
 <20231205091952.24754-1-pchelkin@ispras.ru>
 <ZW7t_rq_a2ag5eoU@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW7t_rq_a2ag5eoU@codewreck.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/12/05 06:31PM, Dominique Martinet wrote:
> Fedor Pchelkin wrote on Tue, Dec 05, 2023 at 12:19:50PM +0300:
> > If an error occurs while processing an array of strings in p9pdu_vreadf
> > then uninitialized members of *wnames array are freed.
> > 
> > Fix this by iterating over only lower indices of the array. Also handle
> > possible uninit *wnames usage if first p9pdu_readf() call inside 'T' case
> > fails.
> > 
> > Found by Linux Verification Center (linuxtesting.org).
> > 
> > Fixes: ace51c4dd2f9 ("9p: add new protocol support code")
> > Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> > ---
> > v2: I've missed that *wnames can also be left uninitialized. Please
> > ignore the patch v1.
> 
> While I agree it's good to initialize it in general, how is that a
> problem here? Do we have users that'd ignore the return code and try to
> use *wnames?
> (The first initialization is required in case the first p9pdu_readf
> fails and *wnames had a non-null initial value, but the second is
> unrelated)
> 

My initial concern was just about the statement you wrote in parenthesis.
Case 'T' can be provided with non-null initial *wnames value, and if the
first p9pdu_readf() call there fails then *wnames is invalidly freed in
error handling path here:

case 'T':{
	[...]
	if (errcode) {
		if (*wnames) {
			int i;

			for (i = 0; i < *nwname; i++)
				kfree((*wnames)[i]);
		}
		kfree(*wnames);
		*wnames = NULL;
	}

So the first initialization is required to prevent the described error.

As for the second initialization (the one located after kfree(*wnames) in
error handling path - it was there all the time), I think it's better not
to touch it. I've just moved kfree and null-assignment under
'if (*wnames)' statement.

The concern you mentioned is about any user that'd ignore the return code
and try to use *wnames (so that the second initialization makes some
sense). I can't see if there is any such user but, as said before, it's
better not to touch that code.

> I don't mind the change even if there isn't but let's add a word in the
> commit message.
> 

OK, will do in v3.

> > As an answer to Dominique's comment: my organization marks this
> > statement in all commits.
> 
> Fair enough, I think you'd get more internet points with a 'Reported-by'
> but I see plenty of such messages in old commits and this isn't
> something I want to argue about -- ok.
> 
> -- 
> Dominique Martinet | Asmadeus
