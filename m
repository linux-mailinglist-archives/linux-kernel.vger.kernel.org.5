Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC3978B4B6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjH1Pn6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Aug 2023 11:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjH1Pny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:43:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19A89D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:43:51 -0700 (PDT)
Received: from hamburger.collabora.co.uk (hamburger.collabora.co.uk [IPv6:2a01:4f8:1c1c:f269::1])
        by madras.collabora.co.uk (Postfix) with ESMTP id 9BB28660716E;
        Mon, 28 Aug 2023 16:43:49 +0100 (BST)
From:   "Helen Mae Koike Fornazier" <helen.koike@collabora.com>
In-Reply-To: <20230828122614.3815122-1-Arvind.Yadav@amd.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date:   Mon, 28 Aug 2023 16:43:49 +0100
Cc:     Christian.Koenig@amd.com, alexander.deucher@amd.com,
        shashank.sharma@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, Felix.Kuehling@amd.com,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
To:     "Arvind Yadav" <Arvind.Yadav@amd.com>
MIME-Version: 1.0
Message-ID: <7d09-64ecc080-1-3ebc5780@85497443>
Subject: =?utf-8?q?Re=3A?= [PATCH v3 0/7] GPU workload hints for better performance
User-Agent: SOGoMail 5.8.4
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 28, 2023 09:26 -03, Arvind Yadav <Arvind.Yadav@amd.com> wrote:

> AMDGPU SOCs supports dynamic workload based power profiles, which can
> provide fine-tuned performance for a particular type of workload.
> This patch series adds an interface to set/reset these power profiles
> based on the submitted job. The driver can dynamically switch
> the power profiles based on submitted job. This can optimize the power
> performance when the particular workload is on. 

Hi Arvind,

Would you mind to test your patchset with drm-ci ? There is a amdgpu
test there and I would love to get your feedback of the ci.

You basically just need to apply the ci patch which is available on
https://cgit.freedesktop.org/drm/drm/log/?h=topic/drm-ci

There are instruction on the docs, but in short: to configure it, you push
your branch to gitlab.freedesktop.org, go to the settings and change the
CI/CD configuration file from .gitlab-ci.yml to drivers/gpu/drm/ci/gitlab-ci.yml,
and you can trigger a pipeline on your branch to get tests running.

(by the time of this writing, gitlab.fdo is under maintenance but should
be up soonish).

Thank you!
Helen

> 
> v2:
> - Splitting workload_profile_set and workload_profile_put
>   into two separate patches.
> - Addressed review comment.
> - Added new suspend function.
> - Added patch to switches the GPU workload mode for KFD. 
> 
> v3:
> - Addressed all review comment.
> - Changed the function name from *_set() to *_get().
> - Now clearing all the profile in work handler.
> - Added *_clear_all function to clear all the power profile.
> 
> 
> Arvind Yadav (7):
>   drm/amdgpu: Added init/fini functions for workload
>   drm/amdgpu: Add new function to set GPU power profile
>   drm/amdgpu: Add new function to put GPU power profile
>   drm/amdgpu: Add suspend function to clear the GPU power profile.
>   drm/amdgpu: Set/Reset GPU workload profile
>   drm/amdgpu: switch workload context to/from compute
>   Revert "drm/amd/amdgpu: switch on/off vcn power profile mode"
> 
>  drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |   8 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   6 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       |   5 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  14 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_workload.c  | 226 ++++++++++++++++++
>  drivers/gpu/drm/amd/include/amdgpu_workload.h |  61 +++++
>  8 files changed, 309 insertions(+), 16 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_workload.c
>  create mode 100644 drivers/gpu/drm/amd/include/amdgpu_workload.h
> 
> -- 
> 2.34.1
>

