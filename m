Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5674E788D8B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 19:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344161AbjHYRCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 13:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344195AbjHYRCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 13:02:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448082121
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 10:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692982908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aJ2tJi24zuLFj3A+pu+XP5QHGUTmirfNDkb8cZUXPw8=;
        b=AYMKd+JY4MCbi35KIcC1gRfVfgTIenEDccJqyFf2UrxXJzfM+HG83ZoFlrRoSnmNLPnvCe
        wsDd14XOZ46V12MTHqars0iEJShvTEYmqzuU5xZHRkAznsbvffOCbOXdVkD6SYDhcvcZ2y
        ZR489CwCBzNoK7harSY8qyiDP9mnHbA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-KXHGz1LvOQeN6eTj6W49lA-1; Fri, 25 Aug 2023 13:01:46 -0400
X-MC-Unique: KXHGz1LvOQeN6eTj6W49lA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-76d9b2b99fbso118934585a.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 10:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692982906; x=1693587706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJ2tJi24zuLFj3A+pu+XP5QHGUTmirfNDkb8cZUXPw8=;
        b=LjzTdwJUCGaC7rFyd+b6Zl/FheJdpJ4aG675EqLOSytVlcpWEcmPQIoOH/YllPMmM+
         vrCLXWwORIihmCOB1vpYdHDjaAlhqYRpTThdXIBxFG2FxPPoxtKszkm0vdqzTcRhFQgg
         tdK/T8vY+mkzEDdUNiibpA67YXbTQdx4eFqiYbZvgOg+NfiifkuFpHzGTDimfWqiLxVV
         3A/4Zz0zU6XhKU3hGpyDQKG5U1H3ja4vxZgVrl6mXS+bGf2OfAGNoIS3ZkCj39wDLiY9
         xD8e4U+i1VREDDDwlxzfudH2FS4DfDaYhfsm8g4sR5NIM6ifp3rjQ4qK+u+W+700DpFt
         zEMQ==
X-Gm-Message-State: AOJu0YzRN4jzHs9KBt/KpdwR6iuI2G5eG5zG3mQskh8hSw1teWJfDTef
        mGh24zlyJIYtFZg1sq9hNvpZCYeMkByeeGawq9YFcDFRoRfF5jiG228DZ7oGz4jD9B48TZ9FoDx
        OTx3mBgCFANtjL4CzKmfz+7nH
X-Received: by 2002:a05:620a:4512:b0:767:3a10:d6de with SMTP id t18-20020a05620a451200b007673a10d6demr22732098qkp.58.1692982906146;
        Fri, 25 Aug 2023 10:01:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9r+hgC07ICJNI/lmyGO6j9NPtPE1qa1auLnJ7Ql2oN7fd3LKPda8+yzOutuYVdg7B7oo5aw==
X-Received: by 2002:a05:620a:4512:b0:767:3a10:d6de with SMTP id t18-20020a05620a451200b007673a10d6demr22732079qkp.58.1692982905906;
        Fri, 25 Aug 2023 10:01:45 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id g24-20020ae9e118000000b00767e2668536sm644165qkm.17.2023.08.25.10.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 10:01:45 -0700 (PDT)
Date:   Fri, 25 Aug 2023 10:01:43 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, zhangzekun11@huawei.com,
        john.g.garry@oracle.com, dheerajkumar.srivastava@amd.com
Subject: Re: [PATCH v2 2/2] iommu/iova: Manage the depot list size
Message-ID: <tfub6qlwprlwhvbuyfzhiqbsdbnzlbnhmteb4xcqd7crrrmopd@2eotamfjn5t6>
References: <cover.1692641204.git.robin.murphy@arm.com>
 <4eb00390132b93bbc113bef2205e9df54f888710.1692641204.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eb00390132b93bbc113bef2205e9df54f888710.1692641204.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 07:22:52PM +0100, Robin Murphy wrote:
> Automatically scaling the depot up to suit the peak capacity of a
> workload is all well and good, but it would be nice to have a way to
> scale it back down again if the workload changes. To that end, add
> backround reclaim that will gradually free surplus magazines if the
> depot size remains above a reasonable threshold for long enough.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

