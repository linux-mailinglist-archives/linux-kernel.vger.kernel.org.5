Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1D2805D90
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbjLESCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjLESCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:02:33 -0500
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7CC122;
        Tue,  5 Dec 2023 10:02:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701799319; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=OZCIJtJgraukf00QLXH1/JTROZPddFlSMELMgKBHZcz1HI0SMnaEeg287DKzb+j6wFhGEh5kTUjcxrURypkXoelW8TsGYkFbJP4Hop3wEEid3lPS6cturw/uBFb3eUXBXnnI/G8gOJLoNnGMHUdctDJH8SX5sO7RDhHqMOqiRJk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1701799319; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=xNtMIw1gYkg4/iqMqcGWC2L7v3kfYsE4S60OOFQ8WUA=; 
        b=Ts708fS/zcB3x34en3v6XzWtaJKSwwfLkacD9cJnx6oTaDy8NRqUfsFPxiGabD4Gzo3qnaoCECkSIAgsvqidcD/K1drXQzSkBmw1Rfa5rOqGhsAhPFTWIBc67UWgFverXmLfJ8pwreXD76z7dROUbCjuCSxIvUi0+NT1yDYzTfM=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1701799319;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=xNtMIw1gYkg4/iqMqcGWC2L7v3kfYsE4S60OOFQ8WUA=;
        b=B1taG/fL9uF528x4RVdjmRVTOzsK4OhrNGEHmd9CEDAfvp5RXFNiKzLdgayXBxfo
        H5HSjdp/CTt46lAilu4jwyn1CCYFE5KPc1gzr3jFEMG9iH1QK+mSqcwEjLHmxYnQMZM
        3k/1FArjjxWwDzTfgMDGbBSRsrf8BO5l3kKvhscw=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1701799288673295.52866850298255; Tue, 5 Dec 2023 23:31:28 +0530 (IST)
Date:   Tue, 05 Dec 2023 23:31:28 +0530
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
Message-ID: <18c3b245f39.5eac9b5898943.4628342226240608054@siddh.me>
In-Reply-To: <d41ea6ff-3c29-4a76-833d-19e6a6649d3c@linaro.org>
References: <cover.1701627492.git.code@siddh.me>
 <4143dc4398aa4940a76d3f375ec7984e98891a11.1701627492.git.code@siddh.me>
 <fd709885-c489-4f84-83ab-53cfb4920094@linaro.org>
 <18c3aff94ef.7cc78f6896702.921153651485959341@siddh.me> <d41ea6ff-3c29-4a76-833d-19e6a6649d3c@linaro.org>
Subject: Re: [PATCH net-next v3 1/2] nfc: llcp_core: Hold a ref to
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

On Tue, 05 Dec 2023 22:57:28 +0530, Krzysztof Kozlowski wrote:
> >> Mismatched order with get. Unwinding is always in reversed order. Or
> >> maybe other order is here on purpose? Then it needs to be explained.
> > 
> > Yes, local_release() will free local, so local->dev cannot be accessed.
> > Will add a comment.
> 
> So the problem is just storing the pointer? That's not really the valid
> reason.

Oops, my bad. What would be the valid reason? (if any)

Thanks,
Siddh
