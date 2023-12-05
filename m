Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F53A805C13
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346071AbjLERZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346056AbjLERZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:25:33 -0500
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62F01A4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:25:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701797109; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=OwXrFQnRWMbGKXs8+HL02CBt0q/f5RKkQDyviQYEdqHjeyAMXS8C6mOybvaoDDB3bLhCPiZUE2jsJEaOolZlgrQ8RXz0O5wlkqFwh6E462VqztysizNqm3mJVrqnLr03xwciAKEQL7W1nvfFcg0A0E7PRW5pMqOap28i5PzwMXI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1701797109; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=7fNJOsQyKCJVxDU+kYFvWKqAIRtDrz/rvo42UT74Mac=; 
        b=IxBSawQdPPq8g1pvb2hMR1YuPckMEyMuFpGYZYh1FEaVafAxHPoZby/QALQjj+xjV//E/1JjFWIc8Wl0oxBglckib+1jEwAUSEj3AD5nhStECZGDu1efpa31vL7M6Ro3RNjHcB+PnAahp8kiUOrHmkBXahZPA0gVzOMR+4GgMLE=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=sanganaka@siddh.me;
        dmarc=pass header.from=<sanganaka@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1701797109;
        s=zmail; d=siddh.me; i=sanganaka@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=7fNJOsQyKCJVxDU+kYFvWKqAIRtDrz/rvo42UT74Mac=;
        b=l9wajJRg1RGLagwq0LbP4ikyzJZF07oyPucg+1i24ZTormJdkw6/mw4LEqvzsAgL
        qZgf6VcXm1YZt7R8mqSM1HYcPzSWUsfmvnLR9vCH4lJG3E3cAZq1LqX+6S59KXgoKxa
        zAtUsm5rOCLhdQIyNG5rN4Bfu8ZHdKrcysexWeks=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1701797077500517.4638203688928; Tue, 5 Dec 2023 22:54:37 +0530 (IST)
Date:   Tue, 05 Dec 2023 22:54:37 +0530
From:   Siddh Raman Pant <sanganaka@siddh.me>
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
Message-ID: <18c3b02a1ef.6fec9cb996724.8771055654191224615@siddh.me>
In-Reply-To: <18c3aff94ef.7cc78f6896702.921153651485959341@siddh.me>
References: <cover.1701627492.git.code@siddh.me>
 <4143dc4398aa4940a76d3f375ec7984e98891a11.1701627492.git.code@siddh.me> <fd709885-c489-4f84-83ab-53cfb4920094@linaro.org> <18c3aff94ef.7cc78f6896702.921153651485959341@siddh.me>
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

On Tue, 05 Dec 2023 22:51:17 +0530, Siddh Raman Pant wrote:
> I agree, it was something I thought about as well. There should be a
> new function for refcount increment. Maybe the existing one could be
> renamed to nfc_get_device_from_idx() and a new nfc_get_device() be
> defined.

Or nfc_find_device() instead of nfc_get_device_from_idx().

Thanks,
Siddh
