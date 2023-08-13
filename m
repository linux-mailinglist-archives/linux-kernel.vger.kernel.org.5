Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7906C77A77A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjHMPcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjHMPcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:32:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC597E0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 08:32:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35B6B62EB6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 15:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681FBC433C8;
        Sun, 13 Aug 2023 15:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691940727;
        bh=pNzd0jPoK1/7tmEtl+sPzQlrbfYgD5Os2z+f6A1BXOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=girRRykMw3vifG+WNE8zFFej5rXPVMxrEVQE8l90xOEBEEhOJhRTcDvmWk1GDConx
         BK0Ul3gXJFyEmsx0mis9goIEzI8rj6GgAw74cx1i+rQcnQpc8ETGYwTIsg2kYB72DV
         TUsZ2JpnNjX6BuNb/mPNCy+8oXRXRlij/hVaT5s4/+CYTjvZfPzK5yGwRKRFsmMp1M
         JXrxL2+K8j3TEzTfkvlK7OnBLdbyTiW4RBSiwraeUZrBhDTzs88d7uoVFUzhZ+0pa7
         c9XEc+yXTOnRMeWM2tE7fcPV47ScVOsVNZo6hwREJUx+CtQhU9P2ezM0tk1Oe0xT1I
         gcQj46AtvNpUg==
Date:   Sun, 13 Aug 2023 17:32:03 +0200
From:   Simon Horman <horms@kernel.org>
To:     Alfred Lee <l00g33k@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        sgarzare@redhat.com, AVKrasnov@sberdevices.ru
Subject: Re: [PATCH v2 net] net: dsa: mv88e6xxx: Wait for EEPROM done before
 HW reset
Message-ID: <ZNj3c2TO6bqfe0IM@vergenet.net>
References: <20230811232832.24321-1-l00g33k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811232832.24321-1-l00g33k@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 04:28:32PM -0700, Alfred Lee wrote:
> If the switch is reset during active EEPROM transactions, as in
> just after an SoC reset after power up, the I2C bus transaction
> may be cut short leaving the EEPROM internal I2C state machine
> in the wrong state.  When the switch is reset again, the bad
> state machine state may result in data being read from the wrong
> memory location causing the switch to enter unexpect mode

nit: unexpect -> unexpected

> rendering it inoperational.
> 
> Fixes: 8abbffd27ced ("net: dsa: mv88e6xxx: Wait for EEPROM done after HW reset")
> Signed-off-by: Alfred Lee <l00g33k@gmail.com>
