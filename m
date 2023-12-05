Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9218054FD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbjLEMnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjLEMnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:43:49 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D290D7;
        Tue,  5 Dec 2023 04:43:55 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 0512EC021; Tue,  5 Dec 2023 13:43:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1701780234; bh=9k2hEUfWqSwjsOCNxJeHa/J+KeqtpWnpfnSOvtCRoqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RgakGAYxKTHmfDsp3Xz4ToOiFec531bEiG1oi9xpE8L6ixaQmDIE2gEe/81AmGTsx
         eRHIgxFTpoptfzdCWKjbWQk2QTwR+BE7qkNahj/nkWO0yDWFek+tn4VLimnd1J70ig
         8ANst0jEIPDChSXLz78NnNS2OnIIuCtJG5ozAjrQejv7GqiBlf/ostfQGsn2/4pMIb
         uXL10maFRsYdzr/npMZvI5/LT0cFtXCym+TKMh9uHo6w0O8q5QYx8xGm56uo1hiikc
         TCfY9o5H4/3geFLUvnLE6+z96SQUa6eaxBbdYt5bwGz+Elje7NcBzuAiwIVVaCCMu+
         4JMcN2RW9w02w==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from gaia (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 79FDEC009;
        Tue,  5 Dec 2023 13:43:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1701780233; bh=9k2hEUfWqSwjsOCNxJeHa/J+KeqtpWnpfnSOvtCRoqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r5l5QQB/eieudp+PT4SYxj+jH20QiV6viRJce+pCsKIvdchAaSSo6NJrm8mbpX077
         4FfxkWQ1sekeWcSekEviSIJyQz6pPS3ChXg/kZtOFoWvFUV214ioLcZ3ymvXOOEFLq
         TFdGCULG3GMJQkCbiNgoSAqnxxJ3Ula5kL07YimK58QyKTqWpFU8zR+2JHu0jHIKqu
         QA7P8uGIOdPCs/vNM+ym0SuZlWDPdbLE5D+Cqwyr+JYnE+ofu4z9wcAaV00YcwQJ1l
         R31riyGsVI5wQdTKV90vNKG1rZwuhw8h67zc4qzlX7UPuI5eSg1AF0Nwwfc70vv8Pw
         9eWMwT5UxDIsg==
Received: from localhost (gaia [local])
        by gaia (OpenSMTPD) with ESMTPA id 98847857;
        Tue, 5 Dec 2023 12:43:47 +0000 (UTC)
Date:   Tue, 5 Dec 2023 21:43:32 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Fedor Pchelkin <pchelkin@ispras.ru>
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
Message-ID: <ZW8a9BvNwO4yw_JX@codewreck.org>
References: <ZW7oQ1KPWTbiGSzL@codewreck.org>
 <20231205091952.24754-1-pchelkin@ispras.ru>
 <ZW7t_rq_a2ag5eoU@codewreck.org>
 <2974507b-57fa-4c9b-a036-055dbf55f6a4-pchelkin@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2974507b-57fa-4c9b-a036-055dbf55f6a4-pchelkin@ispras.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fedor Pchelkin wrote on Tue, Dec 05, 2023 at 03:15:43PM +0300:
> As for the second initialization (the one located after kfree(*wnames) in
> error handling path - it was there all the time), I think it's better not
> to touch it. I've just moved kfree and null-assignment under
> 'if (*wnames)' statement.

Ah, I somehow missed this was just moved; that doesn't change anything
but doesn't hurt either, sure.

> The concern you mentioned is about any user that'd ignore the return code
> and try to use *wnames (so that the second initialization makes some
> sense). I can't see if there is any such user but, as said before, it's
> better not to touch that code.

Yes, it was here before, let's leave it in.

> > I don't mind the change even if there isn't but let's add a word in the
> > commit message.
> 
> OK, will do in v3.

I've queued to -next as is (with the i initialized as Christian pointed
out), will update if you send a new one later.

Thanks,
-- 
Dominique Martinet | Asmadeus
