Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C6680F50A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377040AbjLLR6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjLLR6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:58:24 -0500
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C715C83;
        Tue, 12 Dec 2023 09:58:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1702403865; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=F6p0FZSmO3EPxe8eSMnSkLkPotWa5bJdXUpGCYImizd58LE7U0JvtdvmRCryFYIzV72K3KO7k0CuwRli8yxwpLOdMtWv7qH+FpIsl4ani+mlow/fcetjbrh6lDvTW83hyz894rYbcBznxGKz6PHPdvUj46vG/wtKhH4LCcQKV6E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1702403865; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=Aq+2S0RyfU4rvqFhfAFdSWPubgqSUgNh4Ar82DhKIVk=; 
        b=CKyJsCwxNqONYDQxXd9wp/YqfPRZcLNIs6gShKZU9YsRVFi9kOAUuru3PRgLB+C4lWO4O5SL8GgZL01MU0VqyTJ3b7TSlJXHuk9K9UfzrlWhjcsVV8lA521NDK7NbLDzG6cDfs2OcPMFU8si/k7OC41PLror440JIbng62KLW7Q=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1702403865;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=Aq+2S0RyfU4rvqFhfAFdSWPubgqSUgNh4Ar82DhKIVk=;
        b=pQcV1sAqzD6UV6AYyTKWqQW8rJiVd3HygEozpcdTUbdOaeMjtzZ1HF6iVrqCMP/3
        AhnNTV4kwrRGw27GbkKRhUjYVxp/rbltJFzhV0hFGMq+IjvK4TFIFljCVZuW3i21Jel
        +BGHvIM/2JWY+yQbO6AK1FvDDMmn8GBPcra00ouQ=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1702403834003397.8584939259025; Tue, 12 Dec 2023 23:27:14 +0530 (IST)
Date:   Tue, 12 Dec 2023 23:27:13 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Paolo Abeni" <pabeni@redhat.com>
Cc:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Suman Ghosh" <sumang@marvell.com>,
        "netdev" <netdev@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "syzbot+bbe84a4010eeea00982d" 
        <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
Message-ID: <18c5f2d0084.7d5adcbf247555.1144954964908922966@siddh.me>
In-Reply-To: <94d394d2833754a0a3f7d2cb8c595f44a2b23e43.camel@redhat.com>
References: <cover.1702118242.git.code@siddh.me>
         <4233248c0ca219693c6e6476aa6e59c799241ac8.1702118242.git.code@siddh.me> <94d394d2833754a0a3f7d2cb8c595f44a2b23e43.camel@redhat.com>
Subject: Re: [PATCH net-next v4 1/2] nfc: llcp_core: Hold a ref to
 llcp_local->dev when holding a ref to llcp_local
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 18:31:57 +0530, Paolo Abeni wrote:
> On Sat, 2023-12-09 at 16:34 +0530, Siddh Raman Pant wrote:
> >  static struct nfc_llcp_sock *nfc_llcp_sock_get(struct nfc_llcp_local *local,
> > @@ -930,9 +945,7 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
> >  
> >  	if (sk_acceptq_is_full(parent)) {
> >  		reason = LLCP_DM_REJ;
> 
> 'reason' is set to 'LLCP_DM_REJ' every time you jump to the
> 'fail_put_sock' or 'fail_free_new_sock' labels, you can as well move
> the assignment after 'fail_put_sock:'

Sure, I'll send a patch with that.

Thanks,
Siddh
