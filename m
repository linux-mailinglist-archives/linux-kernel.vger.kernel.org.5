Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319AB7FE43E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 00:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjK2Xoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 18:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjK2Xog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 18:44:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2926AD7D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 15:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701301481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wj14NLUM5uVjUx2vL7JDnyv8GZVAq3JS2Nn/ze66rMg=;
        b=JszVLUSx6w7ahbqVhs7NI+gzMB8NExEUATKIeHMc9SqFGVQnKeVB4LGcrWRaTbJPLUL+5L
        0viC48K6WQbIBGw3HMrRCkJvkjxuxSAFRjJYeM1SykYkAt91rkvGvg6DFen0bKfOqmMHiH
        WqDAT/Giu2D20isXInIzpcDLOtWTZD4=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-O-0PfjqnNre4Dk1bwUvOMw-1; Wed, 29 Nov 2023 18:44:39 -0500
X-MC-Unique: O-0PfjqnNre4Dk1bwUvOMw-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-7c451c4e2a1so116820241.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 15:44:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701301479; x=1701906279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wj14NLUM5uVjUx2vL7JDnyv8GZVAq3JS2Nn/ze66rMg=;
        b=RnZFf38xeOYiymyhvdCo5eskijZJkxUv5FiVszlW41xtuvMqQLEY3LM7sH529/eQHD
         HIWH6pdH4VozIY+6xkwr7yY0uMsjyhgthZ0l4BfhhLXuk6QpNOLm/mNiVJOpoCXoOhCq
         zb0Os+CV93vgvsY/Nv4v1P5BSnc/5W4rrkKSZ253WL7y6EUDFZjYWrb8wPq1bYClJF2n
         2uTpLq0DEaLXeaoZpyfGxq4Bg78hCc9MZfDBMa/XSVjpjHM3tl2BiODy1oJAj9bClv/W
         X5+WRwU0Y02slA9kCmNYhgUUIuNzIfr3OoKEXPqcSGM9HCso1hZIg6Uw1M+gcfy2ZqgC
         vbyg==
X-Gm-Message-State: AOJu0YzUdcTCueb0v4IrWEVa3+TLnYw0hHsgHCbfhMG7dqYi+eHqdS7n
        clxahmVTpY7q15fzyOutQ/Ys11G6AfTbaGJi/xkh4wACzWXz+ZkkmL8h//N95mEA0C0WE8+kStC
        Up9WlbkSkEBGDTc2S7lYkDidnAXT6782fWys1AskT
X-Received: by 2002:a05:6122:caa:b0:4b0:5c0:c006 with SMTP id ba42-20020a0561220caa00b004b005c0c006mr16487599vkb.1.1701301479486;
        Wed, 29 Nov 2023 15:44:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRC4O+v91fwsDKg5BsBJwce57hpPsosPD4pb5IlUJ/m9GK9WnfaytR6VlOSBrHvqIcf2mh7c0vBvyWjokdZ+4=
X-Received: by 2002:a05:6122:caa:b0:4b0:5c0:c006 with SMTP id
 ba42-20020a0561220caa00b004b005c0c006mr16487584vkb.1.1701301479234; Wed, 29
 Nov 2023 15:44:39 -0800 (PST)
MIME-Version: 1.0
References: <20231129221140.614713-1-npache@redhat.com>
In-Reply-To: <20231129221140.614713-1-npache@redhat.com>
From:   Joel Savitz <jsavitz@redhat.com>
Date:   Wed, 29 Nov 2023 18:44:22 -0500
Message-ID: <CAL1p7m5H7YoQFg6BJ1zhPGyvfoL4BP1Tn1t-NYv=g2cuEQwJfg@mail.gmail.com>
Subject: Re: [PATCH] selftests/mm: dont run ksm_functional_tests twice
To:     Nico Pache <npache@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, shuah@kernel.org, akpm@linux-foundation.org,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 5:11=E2=80=AFPM Nico Pache <npache@redhat.com> wrot=
e:
>
> ksm functional test is already being run.
> Remove the duplicate call to ./ksm_functional_tests.
>
> Fixes: 93fb70aa5904 ("selftests/vm: add KSM unmerge tests")
> Signed-off-by: Nico Pache <npache@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> ---
>  tools/testing/selftests/mm/run_vmtests.sh | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/se=
lftests/mm/run_vmtests.sh
> index 00757445278e..c0212258b852 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -334,8 +334,6 @@ CATEGORY=3D"ksm_numa" run_test ./ksm_tests -N -m 0
>
>  CATEGORY=3D"ksm" run_test ./ksm_functional_tests
>
> -run_test ./ksm_functional_tests
> -
>  # protection_keys tests
>  if [ -x ./protection_keys_32 ]
>  then
> --
> 2.41.0
>

Acked-by: Joel Savitz <jsavitz@redhat.com>

