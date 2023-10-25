Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AD77D6F3F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344815AbjJYOOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343719AbjJYOOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:14:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66742A4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:14:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42B3C433C8;
        Wed, 25 Oct 2023 14:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698243250;
        bh=u8Hb+8CBmmdXR1Qra0P9J+M1NhZnHM1zSoQDSKIkf+E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FBxMYZrTnOu+I/bzIz/S2X3Xe36VpCOVt3hg8nsL2D4GTDB63LtkrugeFQpz7DZl+
         AI1kUjP3apyN8JBjjK8IVo11Gv5VRBSxkn5X/3QjHF2eeJVIKwDv7XjiW++HfK4SrI
         +Tc8MU3kIPwG/hT8w1YXEnztFfONJJVG48TXOATncsZ/scGB49/xYzFc6tWeLUqlGQ
         NbOfymHXus9jGMODCz7oCaF519wB56yh6hnqSM4e8SpWs1yX0vOs7SUaB7YZ3vPBn/
         fZjlI9pIWL5nmUkeZ6CdUXySUaS32LbmkByLGjoEKFhzEbjMDIcgeQQ7GTtCMQTAez
         HncWaUKF/CsPw==
Date:   Wed, 25 Oct 2023 07:14:08 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     Hangyu Hua <hbh25y@gmail.com>, borisp@nvidia.com,
        john.fastabend@gmail.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: tls: Fix possible NULL-pointer dereference in
 tls_decrypt_device() and tls_decrypt_sw()
Message-ID: <20231025071408.3b33f733@kernel.org>
In-Reply-To: <ZTjteQgXWKXDqnos@hog>
References: <20231023080611.19244-1-hbh25y@gmail.com>
        <ZTZ9H4aDB45RzrFD@hog>
        <120e6c2c-6122-41db-8c46-7753e9659c70@gmail.com>
        <ZTjteQgXWKXDqnos@hog>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 12:27:05 +0200 Sabrina Dubroca wrote:
> > My bad. I only checked &msg->msg_iter's address in tls_decrypt_sw and found
> > it was wrong. Do I need to make a new patch to fix the harmless bogus
> > pointer?  
> 
> I don't think that's necessary, but maybe it would avoid people trying
> to "fix" this code in the future. Jakub, WDYT?

No strong feelings, but personally I find checks for conditions which
cannot happen decrease the readability. Maybe a comment is better?
