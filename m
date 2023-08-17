Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8BC780138
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355830AbjHQWnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355805AbjHQWmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:42:55 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73619B9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 15:42:53 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fec1a30a1eso33945e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 15:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692312172; x=1692916972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6HhiNeivPc8h3XsvZEVqjvphp3hGJDlkn0WmiMEYNU=;
        b=Ti+3J+EAN7xKagWSnsqm8fc2jskGkx9CO9eA+o6+lcC2J6f9kRRiTXP1K21QqdXtEh
         jcEb+3tfY16mnVTvs9IF0w8PWYQoU3nJV8+DXIG7K8yganeCwCkY0lyKM0flfZyAKq27
         FzABVRE46ujwo6wAwnIfwJn1SiIkXRZiPizsnHlFGMrER5OZWkY1puv4Ilb30q+92uku
         jd4oPjACmDXJoXhATkj0U/JBat6+5We6/ZLwDpMq5N4kDb/kgQeV5HDAudOxNZ57rgjm
         2ZwwwcQvRziZtAbTmBrVeOPvAvC+bNz2lMGIdT4NXFd0zU+8UGIfroZnUziYCV0/ChA7
         tSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692312172; x=1692916972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6HhiNeivPc8h3XsvZEVqjvphp3hGJDlkn0WmiMEYNU=;
        b=WfHv6jW2JkSE1bMrOBiXo9obryY0Wz2o/NMVewtAByEcQNfHvelrN+mQzlRG3mt6CQ
         zosiNLo7S99wkGcXIKyd21jnarWvS3lIzcjJbN5PnE6OL1p1KI3DIy/wI39b5/1pSjJr
         kjhSg9XTs0qJj+UqH4AE7E1W3lOYY5NN9xqGM1HJ536BwNyIV02s1SW1V8JdlcwcB1au
         PKSKok0NJY4x37g2JNiMyuJudJNnN6EV0Z9yB58T8YkMuKUjtFMINVdTvtuVGARAaL4B
         JTew8ebN+alxMKKg1r7lMj5WMNVoLbcRLdMaR7QaylQ828Tt4aZhE1tolLqHICB37xZS
         wtjA==
X-Gm-Message-State: AOJu0YziqgkGCdC3BQZqWcWxn/DShPjlYZLyoTo/7NdQX/jhbhhNvkFV
        7tAW6vbLC9HBBpndntdtBXJZ+9doJuVLCbyCzS7YHQ==
X-Google-Smtp-Source: AGHT+IHz+JQ1gQjOh13G6KUZe0T5nK7totffObGsKPB9aYss5Y2PiLQ4RmPvEVQyXcIAFbbBmd1bbricH5XK4WAFu9s=
X-Received: by 2002:a05:600c:1d02:b0:3f1:9a3d:4f7f with SMTP id
 l2-20020a05600c1d0200b003f19a3d4f7fmr21596wms.1.1692312171931; Thu, 17 Aug
 2023 15:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230816082531.164695-1-sarah.walker@imgtec.com> <20230816082531.164695-14-sarah.walker@imgtec.com>
In-Reply-To: <20230816082531.164695-14-sarah.walker@imgtec.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 18 Aug 2023 00:42:15 +0200
Message-ID: <CAG48ez2xv2i_gObpRZ7v0O8x+dJpHT9a3gcvte7R9_S7bvUNgg@mail.gmail.com>
Subject: Re: [PATCH v5 13/17] drm/imagination: Implement context
 creation/destruction ioctls
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
>
> Implement ioctls for the creation and destruction of contexts. Contexts a=
re
> used for job submission and each is associated with a particular job type=
.
[...]
> +/**
> + * pvr_context_create() - Create a context.
> + * @pvr_file: File to attach the created context to.
> + * @args: Context creation arguments.
> + *
> + * Return:
> + *  * 0 on success, or
> + *  * A negative error code on failure.
> + */
> +int pvr_context_create(struct pvr_file *pvr_file, struct drm_pvr_ioctl_c=
reate_context_args *args)
> +{
> +       struct pvr_device *pvr_dev =3D pvr_file->pvr_dev;
> +       struct pvr_context *ctx;
> +       int ctx_size;
> +       int err;
> +
> +       /* Context creation flags are currently unused and must be zero. =
*/
> +       if (args->flags)
> +               return -EINVAL;
> +
> +       ctx_size =3D get_fw_obj_size(args->type);
> +       if (ctx_size < 0)
> +               return ctx_size;
> +
> +       ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL);
> +       if (!ctx)
> +               return -ENOMEM;
> +
> +       ctx->data_size =3D ctx_size;
> +       ctx->type =3D args->type;
> +       ctx->flags =3D args->flags;
> +       ctx->pvr_dev =3D pvr_dev;
> +       kref_init(&ctx->ref_count);
> +
> +       err =3D remap_priority(pvr_file, args->priority, &ctx->priority);
> +       if (err)
> +               goto err_free_ctx;
> +
> +       ctx->vm_ctx =3D pvr_vm_context_lookup(pvr_file, args->vm_context_=
handle);
> +       if (IS_ERR(ctx->vm_ctx)) {
> +               err =3D PTR_ERR(ctx->vm_ctx);
> +               goto err_free_ctx;
> +       }
> +
> +       ctx->data =3D kzalloc(ctx_size, GFP_KERNEL);
> +       if (!ctx->data) {
> +               err =3D -ENOMEM;
> +               goto err_put_vm;
> +       }
> +
> +       err =3D init_fw_objs(ctx, args, ctx->data);
> +       if (err)
> +               goto err_free_ctx_data;
> +
> +       err =3D pvr_fw_object_create(pvr_dev, ctx_size, PVR_BO_FW_FLAGS_D=
EVICE_UNCACHED,
> +                                  ctx_fw_data_init, ctx, &ctx->fw_obj);
> +       if (err)
> +               goto err_free_ctx_data;
> +
> +       err =3D xa_alloc(&pvr_dev->ctx_ids, &ctx->ctx_id, ctx, xa_limit_3=
2b, GFP_KERNEL);
> +       if (err)
> +               goto err_destroy_fw_obj;
> +
> +       err =3D xa_alloc(&pvr_file->ctx_handles, &args->handle, ctx, xa_l=
imit_32b, GFP_KERNEL);
> +       if (err)
> +               goto err_release_id;

This bailout looks a bit dodgy. We have already inserted ctx into
&pvr_dev->ctx_ids, and now we just take it out again. If someone could
concurrently call pvr_context_lookup_id() on the ID we just allocated
(I don't understand enough about what's going on here at a high level
to be able to tell if that's possible), I think they would be able to
elevate the ctx->ref_count from 1 to 2, and then on the bailout path
we'll just free the ctx without looking at the refcount.

If this can't happen, it might be a good idea to add a comment
explaining why. If it can happen, I guess one way to fix it would be
to replace this last bailout with a call to pvr_context_put()?


> +
> +       return 0;
> +
> +err_release_id:
> +       xa_erase(&pvr_dev->ctx_ids, ctx->ctx_id);
> +
> +err_destroy_fw_obj:
> +       pvr_fw_object_destroy(ctx->fw_obj);
> +
> +err_free_ctx_data:
> +       kfree(ctx->data);
> +
> +err_put_vm:
> +       pvr_vm_context_put(ctx->vm_ctx);
> +
> +err_free_ctx:
> +       kfree(ctx);
> +       return err;
> +}
