Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB85802E5A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjLDJRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjLDJRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:17:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5713E6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 01:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701681434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wVUqyeH/hhJqCTCVnx9jg21J9DGkx6d319y5o3VQXDE=;
        b=YFyNuMZYPz4NbMrOii2rrf8xp1Yg7iSoQOMzMDqpAwG1TJxS/AkxYyL6Rw39gpvjo7gHJh
        0GKeQoh6bMSdw2dxKeRLNUWwIdCD6NWX/m+MlO20FBWb82PooEpdTuMoPS0vu6mEjdmkUh
        tdENw36m/V/JM6rO6s2ITXEpAtLraE0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-dPsVRzaCPCOa8Gov2MoT8g-1; Mon, 04 Dec 2023 04:17:12 -0500
X-MC-Unique: dPsVRzaCPCOa8Gov2MoT8g-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50bf6201648so486733e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 01:17:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701681430; x=1702286230;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wVUqyeH/hhJqCTCVnx9jg21J9DGkx6d319y5o3VQXDE=;
        b=btnPyGJ/AgbzCRCJdU52ULnNNDkyeTEfzcNMxWEuQtTgEw3RjGfL3+RmvmMyg5yYlA
         a34UkEHz25Rk3O4WRm2Ypi+VSYg0TZrHzYXlmbZUpvSPJ1sguaietXklMCvFDEpyyrQH
         51dXdVdGvntT5DIF9/naYGxn2UOfkZ2fgJS4YYnZwlwJADIsuki2aCHFKhjJ0KdEeQED
         JU0DZL3HQSHJo/zy4fMdsGvw5XfBABr/huUKqpu916l1HVMXoBixQCgzLRjnmrBLrlzL
         qscWlLRYErieO0/a7X/VmAT88sxo5e67P9Sl3SEMCgXLXR/0xl7av0nlsnRzlmenU91v
         T2kA==
X-Gm-Message-State: AOJu0YwQXWkw+/MsRtylbLzCMU67+rLGqu3nhM+Ht53zLsJ8AFQoLP5n
        R3UstuQwKA5uuDhDZeUuZo/QMxkD313bUjH1lSYZsN2XZdw+CcYxXks8fXTz2ZHAsdGl8pHuZwR
        0FzbXWZiYUBPkyRRC7+8xn+bq
X-Received: by 2002:a05:6512:15c:b0:50b:fd82:8998 with SMTP id m28-20020a056512015c00b0050bfd828998mr183093lfo.28.1701681430813;
        Mon, 04 Dec 2023 01:17:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzjMjZN6cLv07PRQZ2ojaXg94icdbG+1QZ0CaD/aYYcq8mlzQDzyXWFyzSxSXzXqQQuIcgGA==
X-Received: by 2002:a05:6512:15c:b0:50b:fd82:8998 with SMTP id m28-20020a056512015c00b0050bfd828998mr183087lfo.28.1701681430481;
        Mon, 04 Dec 2023 01:17:10 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id cp6-20020a056000400600b003334520e49bsm3314789wrb.53.2023.12.04.01.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 01:17:09 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Jean Delvare <jdelvare@suse.de>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH RESEND] drm/display: Drop obsolete dependency on
 COMPILE_TEST
In-Reply-To: <20231202213218.7af5ec77@endymion.delvare>
References: <20231202213218.7af5ec77@endymion.delvare>
Date:   Mon, 04 Dec 2023 10:17:09 +0100
Message-ID: <87cyvmxr6y.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
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

Jean Delvare <jdelvare@suse.de> writes:

Hello Jean,

> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

