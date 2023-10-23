Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163677D3AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjJWP0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjJWP0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:26:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44D2FD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698074748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5pB8P5MZI5SVEZkvNE+Ru1LBtul6eHQwWOFc8lfM1dc=;
        b=YhvB1OOzmUAgBjHrISgcI2rvQgJ3tDw0I4NPp6XiOKcUjce+uQ8wVTCWFJXpA1zYLlVtwD
        x5tkakB7RLyso1Ecwq2yO5n20Stuy6V7m1kVgd0n4AyXVIBHRZqsTFr6c43IapmTq/SFRd
        fPR96zorCB8vhb7B4XBKc4VKjlPetTk=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-FnP6EB3cOt62i8AK4zcbRQ-1; Mon, 23 Oct 2023 11:25:46 -0400
X-MC-Unique: FnP6EB3cOt62i8AK4zcbRQ-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6ce37195375so5255045a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698074745; x=1698679545;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5pB8P5MZI5SVEZkvNE+Ru1LBtul6eHQwWOFc8lfM1dc=;
        b=GKxQew5kBWV2fUcsgomUD/bHNHJebkTeU0+OoedgoX/QmNs6d3ejIZknzAajk2mgf5
         jfiYR32Y+cG5q221MpWMsLIbFfMqzdUaouhQ87umXo50Ik3q4+lY+Sx5Py0fPbWaJKlA
         J5PRY8N3ZUc6kDt0sSr/w/YjiKsXj0arXzTtknkgdPVWpzE2+XoAc2K220Nx0yCNJ3si
         1vhyePjPUH+eTtaPJ4T+ycFX2kDXwoGr5ChGGIaBgtcu0YlwgL+vXwtHgP5X3HFFGSSy
         /qbI9cBdv5uxl/HY1IQzQlG2kIukOJBpXp6Kz112g3gK4Zo6Dwx+Ml39WaY8frChg96d
         c7eA==
X-Gm-Message-State: AOJu0Yx0HODFNbqfvTwAmVoZjidGH7BrxTJ/hkTIUz4VAwVHEzSlpt6M
        8ogy4w61pGoROtYAgtJLXyFqBBYFuNQre0Tcq9ZDuqK8sI+e9VSVSetnYUHAzLbjHw1J1jgHbM2
        lTwf/W5cFRSwN5e52DNnSjcbF
X-Received: by 2002:a05:6830:13cc:b0:6bd:b29:85d3 with SMTP id e12-20020a05683013cc00b006bd0b2985d3mr9887448otq.24.1698074745363;
        Mon, 23 Oct 2023 08:25:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoK2+qovEnJ0kBN6PCXBIHQFLPHRIJV2jQ3joRidNulJY5AG6LRxvvWXSsxUzhRkBeB3zQyQ==
X-Received: by 2002:a05:6830:13cc:b0:6bd:b29:85d3 with SMTP id e12-20020a05683013cc00b006bd0b2985d3mr9887424otq.24.1698074745090;
        Mon, 23 Oct 2023 08:25:45 -0700 (PDT)
Received: from rh (p200300c93f0047001ec25c15da4a4a7b.dip0.t-ipconnect.de. [2003:c9:3f00:4700:1ec2:5c15:da4a:4a7b])
        by smtp.gmail.com with ESMTPSA id fb8-20020ad44f08000000b0066d32666a20sm2951492qvb.71.2023.10.23.08.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 08:25:44 -0700 (PDT)
Date:   Mon, 23 Oct 2023 17:25:38 +0200 (CEST)
From:   Sebastian Ott <sebott@redhat.com>
To:     Raghavendra Rao Ananta <rananta@google.com>
cc:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Shaoqin Huang <shahuang@redhat.com>,
        Jing Zhang <jingzhangos@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v8 02/13] KVM: arm64: PMU: Set the default PMU for the
 guest before vCPU reset
In-Reply-To: <20231020214053.2144305-3-rananta@google.com>
Message-ID: <6dcbfe5b-2502-0f04-81dc-a4b19e231f06@redhat.com>
References: <20231020214053.2144305-1-rananta@google.com> <20231020214053.2144305-3-rananta@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2023, Raghavendra Rao Ananta wrote:
> From: Reiji Watanabe <reijiw@google.com>
>
> The following patches will use the number of counters information
> from the arm_pmu and use this to set the PMCR.N for the guest
> during vCPU reset. However, since the guest is not associated
> with any arm_pmu until userspace configures the vPMU device
> attributes, and a reset can happen before this event, assign a
> default PMU to the guest just before doing the reset.
>
> Signed-off-by: Reiji Watanabe <reijiw@google.com>
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>

Reviewed-by: Sebastian Ott <sebott@redhat.com>

