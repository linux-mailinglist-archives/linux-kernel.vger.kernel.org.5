Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FCD7BED72
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378699AbjJIViB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377177AbjJIVh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:37:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB35899
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 14:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696887433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8wiHOUxiajjnHeBrQroPQKoRKotH3a/t84SnD4V8y6c=;
        b=VkGchgASes1XNtH61ADuryXgbjo8/neReAMWaBUtZOScEtbSnye4esZcUVgvDOs6e01afL
        65hfwphMtnVv6tJ+u5nvVF4ilwsMupD+jIY80Bj/tQyD1k1TKl+VnZBs1extGG2JJw1zo9
        3/tYlx+HubxgG1xy8NW8KQcRFJnu32A=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-hDfFZAFHPJe1rR_IcwjEMQ-1; Mon, 09 Oct 2023 17:37:11 -0400
X-MC-Unique: hDfFZAFHPJe1rR_IcwjEMQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-774294bde69so801286985a.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 14:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696887431; x=1697492231;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8wiHOUxiajjnHeBrQroPQKoRKotH3a/t84SnD4V8y6c=;
        b=A1W9WczY5OjmVVKGvsHxx4aGtCg3il/zDjLnK+Z4kq9RI6azzvrkNUII6gB3t8gTaJ
         3Mq2EQMf77F3bJIS83z/W3Odl5mRJ80wBbUm0zdsLmcmsSlOwPG69tMNYdslb+6niXFz
         xMW7tS8zBV/Xp6jhAkN75/ZLobve5mFk18XeH+WHZbNYZPYeym3RLMvaoUg36+FC5waQ
         n2tygeKKBO928jdZzf6rExM/PyNvuZMbSu+5hpspP1B9feHBUZBMy0+D1SIJ1tD78wBu
         bgkvP3gj+zFTydujN7q4N6fNwitiuuzxbpkYizRiS5uMav7jiFrmaTNipzfBhGmaee8w
         GZQA==
X-Gm-Message-State: AOJu0Yz+XLZknT8RgqqpNJDv+51TNH0gyzccMT5oTIEwkKucpgrB0gxr
        hdI7HBW2ntrRH5fHYIs36ZgHHi1YsciLjH8ZiOKc3FKdKAOVBd9RZbldKuyFfut9xCza6+myRSr
        DIVBWxuNOLUgvE9ajtswZIzeC
X-Received: by 2002:a05:620a:c45:b0:76c:b7f0:2bc9 with SMTP id u5-20020a05620a0c4500b0076cb7f02bc9mr18775856qki.16.1696887431190;
        Mon, 09 Oct 2023 14:37:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1/DJrTyEIdfkS2nqcDd8qD8ykOPTlndQuH0p6ATWLeJ7BelfGg5ljaHhfNFoJXY4wO+aR8w==
X-Received: by 2002:a05:620a:c45:b0:76c:b7f0:2bc9 with SMTP id u5-20020a05620a0c4500b0076cb7f02bc9mr18775847qki.16.1696887430939;
        Mon, 09 Oct 2023 14:37:10 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c6c:a300::feb? ([2600:4040:5c6c:a300::feb])
        by smtp.gmail.com with ESMTPSA id v22-20020a05620a123600b0077423f849c3sm3804814qkj.24.2023.10.09.14.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 14:37:10 -0700 (PDT)
Message-ID: <a53adb9e7c598119a490dca20305644d6d7f312a.camel@redhat.com>
Subject: Re: [PATCH v2] drm/nouveau: exec: fix ioctl kernel-doc warning
From:   Lyude Paul <lyude@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Dave Airlie <airlied@redhat.com>,
        Danilo Krummrich <dakr@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
Date:   Mon, 09 Oct 2023 17:37:09 -0400
In-Reply-To: <20231008140231.17921-1-rdunlap@infradead.org>
References: <20231008140231.17921-1-rdunlap@infradead.org>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Sun, 2023-10-08 at 07:02 -0700, Randy Dunlap wrote:
> kernel-doc emits a warning:
>=20
> include/uapi/drm/nouveau_drm.h:49: warning: Cannot understand  * @NOUVEAU=
_GETPARAM_EXEC_PUSH_MAX
>  on line 49 - I thought it was a doc line
>=20
> We don't have a way to document a macro value via kernel-doc, so
> change the "/**" kernel-doc marker to a C comment and format the comment
> more like a kernel-doc comment for consistency.
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
> Cc: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
> ---
> v2: update commit text; somehow I sent a version of the patch before
>     adding the full text.
> v1: https://lore.kernel.org/lkml/20231007005518.32015-1-rdunlap@infradead=
.org/
>=20
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

