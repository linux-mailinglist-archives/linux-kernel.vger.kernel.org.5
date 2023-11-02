Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15417DEC05
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 05:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348499AbjKBErs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 00:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348268AbjKBErq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 00:47:46 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0ABA6
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 21:47:43 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9c5b313b3ffso74504066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 21:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698900462; x=1699505262; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yycdQuA+JTtt5VWNbC0xQ0MSDmdTIynT72RC2eozkfU=;
        b=THsX7EeEmiGAWElNlO0SFRFxoolwsr9f46PZZ8XF8vq/nLX/BTCp+ld42Q0Kgsm6JY
         4vgkYaKnbyGN4IeKV9Kclptxtbj+7ufYk43nivbZLrdFsYU9SoWGMbbkVLQdTle0lY/j
         Snmmzm3T4xFoBSV/DbUp5CsYmuSaC1urI693VfzR3oDeR/e0gXCWlx9JXJBYCG5qXUZI
         JjtiBvATfARKfi/T9mxPHOmcAvN53sBf9riUS68JuokeoAbJ+8c+dh1SzTQqnzjErdGl
         JxrbvxrtSCL4xwHUYxP5KG7GVZGDLjvu5XGrddeL0hzd1YCq/86wrgp4xcx6t6AauZ3x
         B+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698900462; x=1699505262;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yycdQuA+JTtt5VWNbC0xQ0MSDmdTIynT72RC2eozkfU=;
        b=qUvbh5Y0hZdNmTNRngmhzkYO+5S9gLiedc4d18KLcV4vYCfAr8vzFgkdALjNah5XZN
         t3LA7rQ+VfX+uVZd6NNRz8yxPkVtH6mtWk8IZG8xMC3CbijI3XJ4iMwbqF0awQV8Sd7F
         vLGpa973AhY0s8h51xd7qPH02MXzpwFBqVpvMtHPtIk0j/4lFVM5uDdf2C3EQ5VwXyJ+
         MztaLCVkvPvofa14OtFpdYLHLxW+qVQusWoXnKQ3z8pIdepoGoUofI6ZCL/9EDIVRhNZ
         8V4vtaS5m9EW7muQWuGTQjNNjukrtqisuvjEXJW/6ZwXgBDN7UjCCMmJJRgfyPsCnbP7
         Ep2w==
X-Gm-Message-State: AOJu0Yx6BweO1QTSFbhlKTriQb4/TlljRL8VwzfZQUYAJzQCcsSkehsS
        XBr7VfDUU47SgOHxakckdXZTJ7VR/kWSVBq2tgfbXcbzy5s=
X-Google-Smtp-Source: AGHT+IH4ptxiqaBLj89wtLjFhCMXYG7F5hOqvTQwwTniHzXkoQE971X19UAYC9WgBUDCERCr73qs+ot+7Qf4wxGS8to=
X-Received: by 2002:a17:906:bc93:b0:9bd:bbc1:1c5f with SMTP id
 lv19-20020a170906bc9300b009bdbbc11c5fmr2708008ejb.35.1698900461529; Wed, 01
 Nov 2023 21:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231101233113.8059-1-dakr@redhat.com> <20231101233113.8059-13-dakr@redhat.com>
In-Reply-To: <20231101233113.8059-13-dakr@redhat.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 2 Nov 2023 14:47:30 +1000
Message-ID: <CAPM=9tzaFn_vyguD9iEh=Pi+JEFD_5eucJvFPQxt7W6mtvw=-A@mail.gmail.com>
Subject: Re: [PATCH drm-misc-next v8 12/12] drm/nouveau: use GPUVM common infrastructure
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2023 at 09:32, Danilo Krummrich <dakr@redhat.com> wrote:
>
> GPUVM provides common infrastructure to track external and evicted GEM
> objects as well as locking and validation helpers.
>
> Especially external and evicted object tracking is a huge improvement
> compared to the current brute force approach of iterating all mappings
> in order to lock and validate the GPUVM's GEM objects. Hence, make us of
> it.
>
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>

Reviewed-by: Dave Airlie <airlied@redhat.com>

Dave.
