Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1817281386F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444011AbjLNRZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLNRZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:25:07 -0500
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A18499;
        Thu, 14 Dec 2023 09:25:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1702574669; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=IsS9jqdNboH+DokAUmHWqUdAxp2O47MBBHJTb7Dh8wac4DUOZx6ULC2KgjpbCybyXSew3T3QjTNtSSSviySJT2YlYw3WIDIDIK3w+78z2iokrFcqLBobXwVL1ZfGJzb6c8kE1T8RR7SqZZofNhHN5WLHrCVFLUbiYX0kMFBYyqs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1702574669; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=wt/4epX/ikd630E8H32vudYEFiqhHNATnHTpC4Gl3Zw=; 
        b=ZyHXlsU/0eZB83l9Agr4vd5hcci3vL+DaRyfcEEynFd+JkKBbXJyjibopQHAdHthgTBAzu8JQnTVM7JdNnOd4aD7SmUXrFPfI2QC98jEwbHlFavo0k6+5GOY88UCHh9z2V8dVYbGc3ABiiarecKmNL58NKJHEs/cH7QMfdcWNFI=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1702574669;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=wt/4epX/ikd630E8H32vudYEFiqhHNATnHTpC4Gl3Zw=;
        b=etSC+GrbFdDpLBWHJIudygbqtoqUN7XpxfaMwsjjYlbPfUMzayWDO1fyy3AVXh1C
        R9R7xOxYRVhe55/ALgDAvIVatCgtQ/5JTbl0Wqi6J8P36Ucre+efHrFt6NHxNHY0yBx
        0ah92EK14DJOFL1Gxunv4Gis3uvVeg5zdm2mHn/U=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1702574638401587.2154477246745; Thu, 14 Dec 2023 22:53:58 +0530 (IST)
Date:   Thu, 14 Dec 2023 22:53:58 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "Suman Ghosh" <sumang@marvell.com>,
        "netdev" <netdev@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "syzbot+bbe84a4010eeea00982d" 
        <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
Message-ID: <18c695b4512.5afde007311004.1718468931473736202@siddh.me>
In-Reply-To: <1813902b-6afc-4539-96b2-050df6fc75c1@linaro.org>
References: <cover.1702404519.git.code@siddh.me>
 <6a26e3b65817bb31cb11c8dde5b1b420071d944e.1702404519.git.code@siddh.me> <1813902b-6afc-4539-96b2-050df6fc75c1@linaro.org>
Subject: Re: [PATCH net-next v5 1/2] nfc: llcp_core: Hold a ref to
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

On Wed, 13 Dec 2023 13:10:16 +0530, Krzysztof Kozlowski wrote:
> > -	if (sk_acceptq_is_full(parent)) {
> > -		reason = LLCP_DM_REJ;
> > -		release_sock(&sock->sk);
> > -		sock_put(&sock->sk);
> > -		goto fail;
> > -	}
> > +	if (sk_acceptq_is_full(parent))
> > +		goto fail_put_sock;
> 
> I would argue that you reshuffle here more code than needed for the fix.
> 
> This should fix only missing dev reference, not reshuffle code. It's a
> bugfix, not cleanup.

So this should not be done? I did it because you told to extend the
cleanup label in v3 discussion.

Thanks,
Siddh
