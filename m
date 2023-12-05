Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725E7805C28
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346898AbjLEPlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346262AbjLEPlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:41:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8660118D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701790880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CvhR56av4gAhLVevaz2JSGCQQg2cTgXXoi36b5i8+VQ=;
        b=MuGHoukipCyjibW4y8T/r9qPfFzRrkuVJK32AlQqKXBqQFIFXYHhexniQrFUF6faKxASXy
        KF0Lx9WsGIvChx7G94RslfQh2k+mrXUSAZAa14JYYM1Bu/0zSNQX2CAplgHImtp/+gTic1
        RvmrPDa+wyBOCldOzojxKuwaCs+zXpU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-L6jkIKy3N1OPmaaEI3xI_g-1; Tue, 05 Dec 2023 10:40:57 -0500
X-MC-Unique: L6jkIKy3N1OPmaaEI3xI_g-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1d0704bdd5bso16089025ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 07:40:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701790850; x=1702395650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvhR56av4gAhLVevaz2JSGCQQg2cTgXXoi36b5i8+VQ=;
        b=ncAqhM95n/SJlOiS3DK5bRg9oXnuBNdkbifN9sVhMwLYZYP3+Gu6AELrT0l9fxCeCF
         zaRwQVf3q68+/3xwHH8rfbf2jf0oBF9qcxX+bJdswxyMDGmS2WeB0GU/vI9ge614vNm/
         C6oJQ7WVwxGYzmIMVi/uRywGppnLxr4v0jEc2vpeA1+EHnsP0Slwjjs0Eqzfl1g9uw7i
         hHHnnkPM++/9OC2ZRSaPoozIh5+ZPInkFuLBD7e2v8LF+lnyY8pwEfqkTYXxBb3oTWke
         bGii2d1tjulqzTeqMRgYOTw6mbYTZtn6gX1r1MYMyDYVillzLi2dT86Y7WSMwxoxDK4z
         VbQg==
X-Gm-Message-State: AOJu0YyHBw+bfsNyCJQOMSH5nmPBcNCUkqm4eMbjmkE8hkG0tp2VMuDc
        cN+707WnRe7ts5kuZ5CKBqk6vUElYH/cDag5mnAqXeT2o9uwCd6EgctTmHu1ktTpQw37oRUeZ3y
        MXnpMdTQWYA59o0ew/Jaq469c
X-Received: by 2002:a17:902:8f8c:b0:1d0:6ffd:f1f8 with SMTP id z12-20020a1709028f8c00b001d06ffdf1f8mr3364665plo.78.1701790850154;
        Tue, 05 Dec 2023 07:40:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELbxy/B8D8Ivj8dQ1PJh4K071fTj0JsFrU+9jvYbDFFDHZQaJ5+JoV27NRmB6dO31mKVj6Mg==
X-Received: by 2002:a17:902:8f8c:b0:1d0:6ffd:f1f8 with SMTP id z12-20020a1709028f8c00b001d06ffdf1f8mr3364647plo.78.1701790849803;
        Tue, 05 Dec 2023 07:40:49 -0800 (PST)
Received: from pollux ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902a3c500b001cffe1e7374sm1567672plb.214.2023.12.05.07.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 07:40:49 -0800 (PST)
Date:   Tue, 5 Dec 2023 16:40:40 +0100
From:   Danilo Krummrich <dakr@redhat.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     sarah.walker@imgtec.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, matt.coster@imgtec.com,
        donald.robson@imgtec.com
Subject: Re: [PATCH drm-misc-next v2 0/2] PowerVR VM fixes
Message-ID: <ZW9EeFWWZ0BMWIPq@pollux>
References: <20231129220835.297885-1-dakr@redhat.com>
 <j6w6ccewlvoosop77ug56r3sqoi4hglj3ejkyfw4dj3s3pdsw5@b473njzq5u3d>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j6w6ccewlvoosop77ug56r3sqoi4hglj3ejkyfw4dj3s3pdsw5@b473njzq5u3d>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 04:35:00PM +0100, Maxime Ripard wrote:
> Hi,
> 
> On Wed, Nov 29, 2023 at 11:07:59PM +0100, Danilo Krummrich wrote:
> > Some major GPUVM changes landed just before v8 of the PowerVR series. Since v8
> > went in rather quickly (review process was finished otherwise) I haven't had the
> > chance to review the subsequent code changes.
> > 
> > Hence, this series with a few fixes in this context. Plus a minor GPUVM patch to
> > make the drm_gpuvm_prepare_* helpers useful for PowerVR.
> 
> This doesn't apply on drm-misc-next anymore, could you rebase and
> resend?

I already applied the two patches to drm-misc-next.

- Danilo

> 
> Thanks!
> Maxime


