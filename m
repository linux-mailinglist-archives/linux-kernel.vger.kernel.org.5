Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09237CEBCF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344716AbjJRXRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjJRXQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:16:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A1A115
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697670953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eGKv31T20FLnyp7D1PvYxnTsDDoyuURiN0uwwMl987c=;
        b=R4unvUN5to1Kkvvpk4bmruKvVNQKdAPBkcpgq7hM/4hu4fkFBmKRht7C1p7mjXvFI3xYsq
        DJY4QkKezz0LBs/0bDH33OQuWSnunYmfoEzm1/bMFaJN+DRc6NIeUbL86dHPT2QcQk5ejq
        px+7ooVp2ZDiYyzCQlLATSL2DzdeFAs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-gjk2Z5s9NB2-OlzxVlrA-g-1; Wed, 18 Oct 2023 19:15:52 -0400
X-MC-Unique: gjk2Z5s9NB2-OlzxVlrA-g-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7740517a478so896365985a.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697670952; x=1698275752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGKv31T20FLnyp7D1PvYxnTsDDoyuURiN0uwwMl987c=;
        b=dIfR/YQ9z6tFv7UVR1eRP3/F5qMHgzU0sh1lF+H3/qwtM2XzgOIkdy/Uhk5TAzAoc8
         XIhKsoytbpE+/jGqF6Dv9qGk+GpZDJYlHCLoLBSiawsMm0cMp14vN19vYQM7pIBRSzkf
         +nOs2Fck+gjwRr3hF4a1GDByJPOW2546LrQFU1ksunB1EqulDtYTQkQXESnn85hTXR53
         HK/tKEX+ooQMmx1KFtCkRyOOlvcMWyq2NNjWpNXTKPg2189efCR82vjD3yxKRo9Ilhjc
         UMb0eGGVrfvXhevLkRvVWEBJRmTz9Wjur6mnRLWt2HLsiZTvyfyLM83il5gHbvF3xz65
         4cwQ==
X-Gm-Message-State: AOJu0YxUdFXpYlELrRsrTQJot8ZouZ6s3lyZXHp0CR25zeTSqaAdrlC7
        n5Tuz+IbwB7z9QPF0dcY3mMn+NpV4fWeCe0rBqacnpYIOiapjUlPJ70zZLCVhmBDsVgURjWsk7f
        ATPG8FOmxP237jFpcgWURSkDN
X-Received: by 2002:a05:620a:3d13:b0:778:8fdf:1b4 with SMTP id tq19-20020a05620a3d1300b007788fdf01b4mr490888qkn.57.1697670952092;
        Wed, 18 Oct 2023 16:15:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH83FrTQusK8U+MDDlLFi41YWVhe+5MZKC/wYYepqgKFRMYLkBBVQW2YlojFKwcDHI82+ylJQ==
X-Received: by 2002:a05:620a:3d13:b0:778:8fdf:1b4 with SMTP id tq19-20020a05620a3d1300b007788fdf01b4mr490878qkn.57.1697670951842;
        Wed, 18 Oct 2023 16:15:51 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id k16-20020a05620a07f000b00775bb02893esm311733qkk.96.2023.10.18.16.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 16:15:51 -0700 (PDT)
Date:   Wed, 18 Oct 2023 16:15:50 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        jgg@nvidia.com, baolu.lu@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/7] iommu: Decouple iommu_domain_alloc() from bus ops
Message-ID: <oeso4k4afucpvzy7aavon6sazpamn6tonbmaa5rpybcy2bqph4@d7sng6fk3vyt>
References: <cover.1697047261.git.robin.murphy@arm.com>
 <81a0a66d76b3826f1a0b55d7fbaf0986034c7abc.1697047261.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81a0a66d76b3826f1a0b55d7fbaf0986034c7abc.1697047261.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 07:14:51PM +0100, Robin Murphy wrote:
> As the final remaining piece of bus-dependent API, iommu_domain_alloc()
> can now take responsibility for the "one iommu_ops per bus" rule for
> itself. It turns out we can't safely make the internal allocation call
> any more group-based or device-based yet - that will have to wait until
> the external callers can pass the right thing - but we can at least get
> as far as deriving "bus ops" based on which driver is actually managing
> devices on the given bus, rather than whichever driver won the race to
> register first.
> 
> This will then leave us able to convert the last of the core internals
> over to the IOMMU-instance model, allow multiple drivers to register and
> actually coexist (modulo the above limitation for unmanaged domain users
> in the short term), and start trying to solve the long-standing
> iommu_probe_device() mess.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> ---
> 
> v5: Rewrite, de-scoping to just retrieve ops under the same assumptions
>     as the existing code.
> ---

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

