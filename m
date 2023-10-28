Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDC37DA964
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 23:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjJ1VJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 17:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1VJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 17:09:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7470B8;
        Sat, 28 Oct 2023 14:09:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB32C433C8;
        Sat, 28 Oct 2023 21:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698527372;
        bh=Wyr214KNSlnSWHwuMNRLzj8fmPHGsLCvoHa+yx4LD2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HAkFHdXrEJ5NUZx0+7uR1BgK9gapGCmVtZlckCrNLoKRh322FrjpBp5EyQxesjxAI
         uHpkCcfmi5pFr7LHoGu8/Q0RwEM6y622KXmLjFQ+8ZxjTFfMcz0U6NeZ6yvBOSaAOq
         wzP7z4L/N9gjVH/FPAPz/YA4YM3PIkS4fNMkU2ORuT0pl4AhDKLrs1L7N7rd7imngt
         smoA22ePDhKjc1CKDInPfCPMfxqoQCUBRyVM+3+HL3zs/tX27rfkS0Yjt+OhbT+nH1
         9tevZoYzzbB8FGlY/W1Kry7tZVlbJSu/wRpJPvUpf4Ou511hW9rfPLs5iWzrkkSSN/
         7639m0hyt65Aw==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/sysfs: remove requested targets when online-commit inputs
Date:   Sat, 28 Oct 2023 21:09:30 +0000
Message-Id: <20231028210930.62947-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022210735.46409-2-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Oct 2023 21:07:33 +0000 SeongJae Park <sj@kernel.org> wrote:

> damon_sysfs_set_targets(), which updates the targets of the context for
> online commitment, do not remove targets that removed from the
> corresponding sysfs files.  As a result, more than intended targets of
> the context can exist and hence consume memory and monitoring CPU
> resource more than expected.
> 
> Fix it by removing all targets of the context and fill up again using
> the user input.  This could cause unnecessary memory dealloc and realloc
> operations, but this is not a hot code path.  Also, note that
> damon_target is stateless, and hence no data is lost.

This is not true.  'struct damon_target' contains monitoring results
(regions_list).  Hence, this patch makes all monitoring results to be removed
whenever doing online-commit.  I was confused with init_regions at the time of
this writing, sorry.

I will send a fix for this soon.


Thanks,
SJ
