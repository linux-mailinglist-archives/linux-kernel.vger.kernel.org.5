Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2CE780139
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355840AbjHQWnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355810AbjHQWnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:43:01 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C71C1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 15:43:00 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe2d620d17so34995e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 15:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692312178; x=1692916978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flLL963OZO6MKJl1cOQ/x7lYi72IoXCt4AG7n6UpQJE=;
        b=TTBApXBmE6mxK+ldLEaOyXK1ktIMX8Ll3lLmp6rL4nIHKnK1rAjNjlQyERzLT9MCDd
         sv7MldySXOJj8moWvQol6Jto4duZFtD1Wwm3gyq4MIL0jU16aKLIFmn/p69iNC64yP3x
         Ng2fO9YHyIpX05r29GEaFbswdrFS5XrD3cflAmgMgPYM9Bp+ZKfU1zGNqq2irB3Bo17t
         oy8RLqHQBCt81qzV5N5x7Um/cZ1K3F2XLGDO0POZXfokkgp5ckH847XVVHf0Q1XjBY2t
         BUHq1dNtKEFh18M8JIVFBBWsQcK+bKVO8pLSHLDyNWgrHkxFIV232JhwGSVVoM952Q0s
         n5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692312178; x=1692916978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flLL963OZO6MKJl1cOQ/x7lYi72IoXCt4AG7n6UpQJE=;
        b=AAUMiDf+wC3qP2TuSyCQCS/pMdv+43yN8GxCm7ZuVuOEjRAnU4rUMzmzu9H6G9Gm1b
         ixbA1YhQ8qMSQkeRp6gRbr+e5SczAt2l+0afNAnfEeSxyU820BhWPGHfrkbmqKQwiZ+c
         XuJmIPKzK0Jj3PfvMgtMpvQqB/MseQ4NQhMMcLnYWfBerhwKeSttd5s+QwfyIfhzAXR4
         itMNJbeXi+iXeSiK+bwOifqg0MgRKMcjongmA0URQ6XlwxGlE4AG8UxIX/Pexqt95fQa
         K+twvP2aX9HJ15L48+LTOKQgm8HHvnMt6/bbOKtSEi/EyCDxjO4fJYu+mDIw5/VBBgMt
         2UMQ==
X-Gm-Message-State: AOJu0YwlkyIfmxGEzMjWPxwObGW9v2paX9o7E86ftqx229wWK8bKMAsD
        XE0awxh5snAEa5yjCZeYdx7tE5sf3MKJpVkgFhGPvw==
X-Google-Smtp-Source: AGHT+IEz4VrA6B0r/0qbrYh7/rbK8tRJiH424JE9aDodokgMGzo2sPKW8swxWTuYM/YpZy4qbDciJbY9zb5h2KFCPtA=
X-Received: by 2002:a1c:770b:0:b0:3f1:70d1:21a6 with SMTP id
 t11-20020a1c770b000000b003f170d121a6mr46988wmi.0.1692312178730; Thu, 17 Aug
 2023 15:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230816082531.164695-1-sarah.walker@imgtec.com> <20230816082531.164695-15-sarah.walker@imgtec.com>
In-Reply-To: <20230816082531.164695-15-sarah.walker@imgtec.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 18 Aug 2023 00:42:21 +0200
Message-ID: <CAG48ez3_ye3jp9Aqn5yi+bjVGWvCJt89TSLW1EOgX_RisXYNBA@mail.gmail.com>
Subject: Re: [PATCH v5 14/17] drm/imagination: Implement job submission and scheduling
To:     Sarah Walker <sarah.walker@imgtec.com>
Cc:     dri-devel@lists.freedesktop.org, matthew.brost@intel.com,
        luben.tuikov@amd.com, tzimmermann@suse.de,
        linux-kernel@vger.kernel.org, mripard@kernel.org, afd@ti.com,
        boris.brezillon@collabora.com, dakr@redhat.com,
        donald.robson@imgtec.com, hns@goldelico.com,
        christian.koenig@amd.com, faith.ekstrand@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 10:25=E2=80=AFAM Sarah Walker <sarah.walker@imgtec.=
com> wrote:
> Implement job submission ioctl. Job scheduling is implemented using
> drm_sched.
[...]
> +/**
> + * pvr_job_data_fini() - Cleanup all allocs used to set up job submissio=
n.
> + * @job_data: Job data array.
> + * @job_count: Number of members of @job_data.
> + */
> +static void
> +pvr_job_data_fini(struct pvr_job_data *job_data, u32 job_count)
> +{
> +       for (u32 i =3D 0; i < job_count; i++) {
> +               pvr_job_put(job_data[i].job);
> +               kvfree(job_data[i].sync_ops);
> +       }
> +}
> +
> +/**
> + * pvr_job_data_init() - Init an array of created jobs, associating them=
 with
> + * the appropriate sync_ops args, which will be copied in.
> + * @pvr_dev: Target PowerVR device.
> + * @pvr_file: Pointer to PowerVR file structure.
> + * @job_args: Job args array copied from user.
> + * @job_count: Number of members of @job_args.
> + * @job_data_out: Job data array.
> + */
> +static int pvr_job_data_init(struct pvr_device *pvr_dev,
> +                            struct pvr_file *pvr_file,
> +                            struct drm_pvr_job *job_args,
> +                            u32 *job_count,
> +                            struct pvr_job_data *job_data_out)
> +{
> +       int err =3D 0, i =3D 0;
> +
> +       for (; i < *job_count; i++) {
> +               job_data_out[i].job =3D
> +                       create_job(pvr_dev, pvr_file, &job_args[i]);
> +               err =3D PTR_ERR_OR_ZERO(job_data_out[i].job);
> +
> +               if (err) {
> +                       *job_count =3D i;
> +                       job_data_out[i].job =3D NULL;
> +                       goto err_cleanup;

I think this bailout looks fine...

> +               }
> +
> +               err =3D PVR_UOBJ_GET_ARRAY(job_data_out[i].sync_ops,
> +                                        &job_args[i].sync_ops);
> +               if (err) {
> +                       *job_count =3D i;
> +                       goto err_cleanup;

... but this bailout looks like it has an off-by-one. We have
initialized the job pointers up to (inclusive) index i...

> +               }
> +
> +               job_data_out[i].sync_op_count =3D job_args[i].sync_ops.co=
unt;
> +       }
> +
> +       return 0;
> +
> +err_cleanup:
> +       pvr_job_data_fini(job_data_out, i);

... but then we pass i to pvr_job_data_fini() as the exclusive limit
of job indices to free? I think this will leave a leaked job around.


> +
> +       return err;
> +}
