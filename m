Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37487DEBFB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 05:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348501AbjKBEol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 00:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjKBEok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 00:44:40 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266D3DE
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 21:44:37 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9d242846194so72758466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 21:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698900275; x=1699505075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I+VxWQ4k/E3/qla6JztW2qtYTnXXlUbK1ykpNWnBSc4=;
        b=f2XFT1nX3axLaYF6YR0rgEYhyXPGJVAhrZ/CUlbQA2H14YlIup17APiQP6sSiIvaPg
         H2XnkTwR8gV3RsDqBz5zTASzORLiLFROnMpffaWR/LemcX3rxtu0ZSpe7UIiiXFQAU0m
         lOIWIX7JBjmbiLbZnx1FN4mYF8ZHgw4ZEt7ZwhmWWD6YSq+Jvq4iLdGhrx9wnC6M66kU
         zI1VFphRodfpuETQTBuCARpcUEEQcleCfx4Jw1CJnh/3pdQTEo6UXVIR3UxWileElqVn
         Jy2BCls/YdJU5b33j7+ZTnUUQmLFalxCMyoIvdy7BBoTl+9wgL5YmBEVbrw1xfK9SPnJ
         JZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698900275; x=1699505075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+VxWQ4k/E3/qla6JztW2qtYTnXXlUbK1ykpNWnBSc4=;
        b=CQ+VQLeBzy5A3Pp/NAT/tsv2wqEDAMdw8v9PQ01jNKwjJxDndoNTSzFCWhxBHcOovQ
         jOFdrmwbocTHSMOvIHG69qq2V9pzPlBYIqUODlRfDP0qV/WpzvnaJR3D1rW7t9FiJL3h
         XjSbb/V23Hfjv9alnHhZ1BkiSSIoFsT8Iys1+NWwxCYuL8ljDja2vCyGzjy4sBKceC9l
         ReC9JVQKEk8sg6khrUmq9+a11PR/JXOW6feiY+ioeAteMwfUfoTO6NxmL7Rq88N2bHIh
         MEXi4Sl5JFe8iRa+PfjjAQr0OC/S0OTawY9T/wJ/4mAlcNJR98E6Ge/gIEPvs5GyDRbM
         r3qQ==
X-Gm-Message-State: AOJu0YyUcmEQ8lp/1BXptC7NSu7h5WlPLqcGY5LMKV6VO1r3AdNEYZbY
        gWXMtw9mB7XFZFAEtDx/lxEgHDnfNm/n0vphgNQ=
X-Google-Smtp-Source: AGHT+IFKP1gGRhZOBwRbI3b3qzBxHp0gy+npS/PRjk49h25MKVTvezOcJ7G2BWNnJLD28VMz4AB72Bpi6b7vF1+u4Q0=
X-Received: by 2002:a17:907:841:b0:9bf:65b0:1122 with SMTP id
 ww1-20020a170907084100b009bf65b01122mr3308085ejb.69.1698900275330; Wed, 01
 Nov 2023 21:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231101233113.8059-1-dakr@redhat.com> <20231101233113.8059-9-dakr@redhat.com>
In-Reply-To: <20231101233113.8059-9-dakr@redhat.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 2 Nov 2023 14:44:23 +1000
Message-ID: <CAPM=9tx2CrrLWddTW0-sYCndsGq+tmc-hFZi0mmBFBJ0SDy-rQ@mail.gmail.com>
Subject: Re: [PATCH drm-misc-next v8 08/12] drm/nouveau: separately allocate
 struct nouveau_uvmm
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

On Thu, 2 Nov 2023 at 09:31, Danilo Krummrich <dakr@redhat.com> wrote:
>
> Allocate struct nouveau_uvmm separately in preparation for subsequent
> commits introducing reference counting for struct drm_gpuvm.
>
> While at it, get rid of nouveau_uvmm_init() as indirection of
> nouveau_uvmm_ioctl_vm_init() and perform some minor cleanups.
>
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>

Reviewed-by: Dave Airlie <airlied@redhat.com>
