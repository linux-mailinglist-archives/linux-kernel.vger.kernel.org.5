Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B2F7527F0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjGMQCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjGMQCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:02:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5192708
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:02:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DE6C619DD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 16:02:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40ADEC433C7;
        Thu, 13 Jul 2023 16:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689264155;
        bh=cM/w8DteIuiCvz+ZdOohIJG9HbMzhPuzehxZjaExPPE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IHk2BQIPyuKXc0oD1dqRMspUjGJMk/7mHCtXHU+bXtN4XIqwPOFmHnb6/vIcA6N06
         c2FsW26g3Qo7Cte81e/mf5NBDtGJ0FTRLR1SdhmkeCZLlTMT+1BDAoMJkfsNYqa//4
         R5ZltZMOYzASVflX4s2vSTbRSTE2TVYiXDyAhAU4zmlTJms01Djb/5eJBhrapfGJO+
         8WHgrXBSQ2GRbXL4hd/vUpR4PxpsDEzWQHVjPnoqFOtK3e+yjUJAihwbz2bnQ0KQkF
         bxrvs8SRpC8kpjYwV8GGUWz6wlhLcdkhSoZig1xJDrZgmDS/Fy6JLtZxtZpR+eGBir
         fpuuOakfcAeMg==
Date:   Thu, 13 Jul 2023 09:02:34 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
        chuck.lever@oracle.com
Subject: Re: [PATCH net-next 1/2 v2] tools: ynl-gen: fix enum index in
 _decode_enum(..)
Message-ID: <20230713090234.28b04145@kernel.org>
In-Reply-To: <20230713090550.132858-2-arkadiusz.kubalewski@intel.com>
References: <20230713090550.132858-1-arkadiusz.kubalewski@intel.com>
        <20230713090550.132858-2-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023 11:05:49 +0200 Arkadiusz Kubalewski wrote:
> -        i = attr_spec.get('value-start', 0)
>          if 'enum-as-flags' in attr_spec and attr_spec['enum-as-flags']:
>              value = set()
>              while raw:
>                  if raw & 1:
> -                    value.add(enum.entries_by_val[i].name)
> +                    value.add(enum.entries_by_val[raw & 1].name)
>                  raw >>= 1
> -                i += 1

This doesn't make sense, as I suggested you need to keep i for this
loop. Move it to the inside of the if 'enum-as-fla... and init to 0.

i is tracking which bit number we are at as we consume / shift out
bits from raw.

Have you ever used ChatGPT? No shame, just curious.
-- 
pw-bot: cr
