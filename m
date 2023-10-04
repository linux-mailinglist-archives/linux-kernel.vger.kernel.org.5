Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938687B85E7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243522AbjJDQyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243590AbjJDQyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:54:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A58112;
        Wed,  4 Oct 2023 09:54:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42553C433C9;
        Wed,  4 Oct 2023 16:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696438472;
        bh=VpzyBn3Pwo9+mwRDTSw2t9nV2rS3KflHer205rUr8ec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mNeNF8ppZsNimabomo0sOLVL5LVo7YlSYKE6MvG4KPQC2fW1tSDEX1absM2bvoTeo
         AGFB7gRvoGpM7oTT7hn8u5dswttm7l7Hy+FZhCQHosnJISjohT2EXEmLJJN8DJGWhh
         6zNvX02klCMsOnPZ+3+CTFOqthkeLkm4I2Zq0iqYQY0SoxYnnCgLzr9740TqARkWPl
         +nmk7SdBx0DobLYKsXzwaMx9mO2AAgb9ElF//O+Wa4NfHaK1G2bLOIMMnhTrOCtwKh
         5/3ckG02jIQGLH7Ja2IfAFvOzda+FLHxX/tRu5qcZdcD+kb0Im/BHAQmuaAOjmhV2s
         VicGPxkROFeDg==
Date:   Wed, 4 Oct 2023 09:54:31 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/4] tracing: improve symbolic printing
Message-ID: <20231004095431.1dd234e6@kernel.org>
In-Reply-To: <20231004123524.27feeae7@gandalf.local.home>
References: <20230921085129.261556-5-johannes@sipsolutions.net>
        <20231004092205.02c8eb0b@kernel.org>
        <20231004123524.27feeae7@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2023 12:35:24 -0400 Steven Rostedt wrote:
> > Potentially naive question - the trace point holds enum skb_drop_reason.
> > The user space can get the names from BTF. Can we not teach user space
> > to generically look up names of enums in BTF?  
> 
> That puts a hard requirement to include BTF in builds where it was not
> needed before. I really do not want to build with BTF just to get access to
> these symbols. And since this is used by the embedded world, and BTF is
> extremely bloated, the short answer is "No".

Dunno. BTF is there most of the time. It could make the life of
majority of the users far more pleasant.

I hope we can at least agree that the current methods of generating 
the string arrays at C level are... aesthetically displeasing.
