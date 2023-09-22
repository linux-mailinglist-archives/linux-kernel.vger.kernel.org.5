Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395757AB9BF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 21:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbjIVTBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 15:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbjIVTBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 15:01:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D88CA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 12:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695409252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=llC9/wUzzd4JVzDSD0PHMCO4lX+W74lZOeDntPKMIjc=;
        b=eNi8Oy/uHTsvEc1urWWxIBNR5mqWngmwD9MO0FTjbqNZ9SSTDZ1Wx6Cah+ozO7AOcNLNJV
        d3cg47cNdg61253zxbk9dCcHB3r8/pL3CYxYkqwAOOumK0h9h17aJr750TcSniWvx3UcKm
        wAJKdjKe5Ugrdq8936jD3FzjvtRy4G0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-F4nQ1I1OOJOQLaN1dHUP_Q-1; Fri, 22 Sep 2023 15:00:51 -0400
X-MC-Unique: F4nQ1I1OOJOQLaN1dHUP_Q-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-65648d20aeeso24657296d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 12:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695409250; x=1696014050;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=llC9/wUzzd4JVzDSD0PHMCO4lX+W74lZOeDntPKMIjc=;
        b=BnFL3SySmEvnPsJvGj2a/7TKhssv7UZgTN6CiO+e9E9GjsURdv25XpqvygwdpxKoqE
         0GOE7vvrCygrepePCwZ5tGMrxR/PR66+lVW4HDZ2xPytLgmbi66aGJItbDmfs72N6bq1
         eJhZtRsLaaS4yrekpZLPZrwXA/TeSN8ZSbEadEQnfuEm4iwVBWSpSyPyo9zwhreu1KMa
         HtDmPApCOcg07VYDjLlfdYtwKtI9rBsu5aMXzj9lnnIqP4iPsLXNn0UJpXYVjsD6kA1+
         KkGzmYWmE5x6LltQQmFN2YCyfgGxaTxTONOp+GnKMyRAuil32SUIdEaTjHkPQaW5Xe6v
         2ziw==
X-Gm-Message-State: AOJu0YwFp7oov6PJ14iEYa7HpwXwPOvooXvtxTF2AdvRlOPxiv+eE7oJ
        HgFxLnl0/BZIvFATjqbihCamMAdRu7SKmBIYV5+TB27YWkj+CDQLbKILmQEAq9av/PyK93lgDyn
        Y5O/xSvbwovvcoP+UvdxsfwNK
X-Received: by 2002:a05:6214:1845:b0:655:d2c7:a9d1 with SMTP id d5-20020a056214184500b00655d2c7a9d1mr187758qvy.14.1695409250676;
        Fri, 22 Sep 2023 12:00:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcAhYi3agHEIh1mExaRpOkIAUDfxEWkbuUfbk0Y5Ex6ReRQkYaRYp/G33/F11gHisOBD3h3Q==
X-Received: by 2002:a05:6214:1845:b0:655:d2c7:a9d1 with SMTP id d5-20020a056214184500b00655d2c7a9d1mr187719qvy.14.1695409250417;
        Fri, 22 Sep 2023 12:00:50 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c6c:a300::feb? ([2600:4040:5c6c:a300::feb])
        by smtp.gmail.com with ESMTPSA id w6-20020a0ce106000000b0064f50e2c551sm1671895qvk.1.2023.09.22.12.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 12:00:49 -0700 (PDT)
Message-ID: <1fc22ed54041660dfff5b7f3cc69708fd4ac0472.camel@redhat.com>
Subject: Re: [PATCH 5/9] drm/nouveau/pm: Annotate struct nvkm_perfdom with
 __counted_by
From:   Lyude Paul <lyude@redhat.com>
To:     Kees Cook <keescook@chromium.org>, David Airlie <airlied@gmail.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Emma Anholt <emma@anholt.net>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        John Harrison <john.c.harrison@Intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Zack Rusin <zackr@vmware.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        Melissa Wen <mwen@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Le Ma <le.ma@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Yifan Zhang <yifan1.zhang@amd.com>,
        Prike Liang <Prike.Liang@amd.com>, Lang Yu <Lang.Yu@amd.com>,
        Tejas Upadhyay <tejas.upadhyay@intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Date:   Fri, 22 Sep 2023 15:00:47 -0400
In-Reply-To: <20230922173216.3823169-5-keescook@chromium.org>
References: <20230922173110.work.084-kees@kernel.org>
         <20230922173216.3823169-5-keescook@chromium.org>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Thanks!

On Fri, 2023-09-22 at 10:32 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUND=
S
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>=20
> As found with Coccinelle[1], add __counted_by for struct nvkm_perfdom.
>=20
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/c=
ounted_by.cocci
>=20
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h b/drivers/gpu/=
drm/nouveau/nvkm/engine/pm/priv.h
> index 6ae25d3e7f45..c011227f7052 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h
> @@ -82,7 +82,7 @@ struct nvkm_perfdom {
>  	u8  mode;
>  	u32 clk;
>  	u16 signal_nr;
> -	struct nvkm_perfsig signal[];
> +	struct nvkm_perfsig signal[] __counted_by(signal_nr);
>  };
> =20
>  struct nvkm_funcdom {

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

