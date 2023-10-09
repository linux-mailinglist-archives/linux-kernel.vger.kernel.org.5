Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D386E7BED90
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378827AbjJIVs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378821AbjJIVs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:48:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7EE99
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 14:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696888058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ol7U8OKowEqtq5uPO63v6h+CJlOTYPJm/cIb2Hh14MU=;
        b=Iy2uXyRmCbjituJWgw71UB16DN9WN7QOy8geqTk4xvDMnX8pDU04cqoTzRm9O9wXlH1iLf
        tS54Vmw36d7Xw0qm2xuhNnCCpXLoNdxlkrr1f5+Mnd/COrcUOVf3H9AVqup25bn7+vj65k
        i5YNp8nYl/HBWJGeJSbtoxk/mdHKX/8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-cvtnAKVEPkm-wECvum_Gtg-1; Mon, 09 Oct 2023 17:47:36 -0400
X-MC-Unique: cvtnAKVEPkm-wECvum_Gtg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-66885ff2a0dso60715996d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 14:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696888056; x=1697492856;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ol7U8OKowEqtq5uPO63v6h+CJlOTYPJm/cIb2Hh14MU=;
        b=AuiBtnRq8iYSQkMKXiwnbczrELR6ruu44YA/7iXS20j618G+of9oJSDkPvyN01Fea1
         GSSIw4i4DlW3rU09Zr33srgq9rUX/vNGecPPtrQ0Zxu4z+MogGrWwKMxdkod4f760qfZ
         XtxGTgapbEL0WN+OKvEIeggqkfuCGZN29PJ6cJa26VGaedrJbPNnddeisyShR71TaSfS
         HvJwVzl/heDmab0MwCN25Je1FDlnuQhOHrjZIYZZqgOCRLOl5vydCh9UHKvgWJ/D0yod
         fZLeDf6QSG1MX0bzfFKTSo5sp2MvacK5kCsxb/Jub+QoyFeBs0NtbS1emVMqPo0XgQVH
         Q1Hg==
X-Gm-Message-State: AOJu0YzXAlnewYwO2o6VrEgkvg7DbDAgI1N2LDhvG6EhTZSt7JOgseSN
        4Adjc3sWSZddrTicmPYHSplEEh3C8UVhGoFBgS1x7w+4EyrdfaF5ecRO7eWGUsvqJKu8RbzXgxz
        biI2cxnfyjhAGuqd83lLX5eGdf4BuenmZ
X-Received: by 2002:a0c:dd87:0:b0:658:a043:376b with SMTP id v7-20020a0cdd87000000b00658a043376bmr17087604qvk.8.1696888056221;
        Mon, 09 Oct 2023 14:47:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOke8zf4DZ25JuBWmIWAQ89mvWVhG4qPWk2Q0cT+WH8YONLgZ9WVcabvZ/wTXpE0AjungOEQ==
X-Received: by 2002:a0c:dd87:0:b0:658:a043:376b with SMTP id v7-20020a0cdd87000000b00658a043376bmr17087594qvk.8.1696888056012;
        Mon, 09 Oct 2023 14:47:36 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c6c:a300::feb? ([2600:4040:5c6c:a300::feb])
        by smtp.gmail.com with ESMTPSA id z19-20020a0cda93000000b0065b31dfdf70sm4173364qvj.11.2023.10.09.14.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 14:47:35 -0700 (PDT)
Message-ID: <e494d9fe7efd72ca3588710388411e98c82ff3f7.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau: exec: fix ioctl kernel-doc warning
From:   Lyude Paul <lyude@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Dave Airlie <airlied@redhat.com>,
        Danilo Krummrich <dakr@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Date:   Mon, 09 Oct 2023 17:47:35 -0400
In-Reply-To: <20231007005518.32015-1-rdunlap@infradead.org>
References: <20231007005518.32015-1-rdunlap@infradead.org>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Fri, 2023-10-06 at 17:55 -0700, Randy Dunlap wrote:
> include/uapi/drm/nouveau_drm.h:49: warning: Cannot understand  * @NOUVEAU=
_GETPARAM_EXEC_PUSH_MAX
>  on line 49 - I thought it was a doc line
>=20
> Fixes: d59e75eef52d ("drm/nouveau: exec: report max pushs through getpara=
m")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Danilo Krummrich <dakr@redhat.com>
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> ---
>  include/uapi/drm/nouveau_drm.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff -- a/include/uapi/drm/nouveau_drm.h b/include/uapi/drm/nouveau_drm.h
> --- a/include/uapi/drm/nouveau_drm.h
> +++ b/include/uapi/drm/nouveau_drm.h
> @@ -45,8 +45,8 @@ extern "C" {
>  #define NOUVEAU_GETPARAM_HAS_BO_USAGE    15
>  #define NOUVEAU_GETPARAM_HAS_PAGEFLIP    16
> =20
> -/**
> - * @NOUVEAU_GETPARAM_EXEC_PUSH_MAX
> +/*
> + * NOUVEAU_GETPARAM_EXEC_PUSH_MAX - query max pushes through getparam
>   *
>   * Query the maximum amount of IBs that can be pushed through a single
>   * &drm_nouveau_exec structure and hence a single &DRM_IOCTL_NOUVEAU_EXE=
C
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

