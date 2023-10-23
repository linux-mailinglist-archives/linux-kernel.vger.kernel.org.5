Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9AB7D3C31
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbjJWQUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbjJWQT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:19:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5B72118
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698077922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ut5czDDze7j+1Ijghpb8c61xr1AzZHB+GaM5+Au8mg8=;
        b=IlOlxfdP7LrG7oi3w1QX1oMLa3S6BnzjrqX3acHxKXW0lOZqOmWXYcM8eEt4Y+Tm/k0/Nt
        RRfRxNURh3HGlN9hma/8QgJn5mV/OIxWmJ6H9Ic8NcIXTwLa1ez6/arWQrHv1NSRxZVcNk
        Lzqn9RuCoSeFSD0c8CKclH2IsRzALFE=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-cAttNStIOn2a7jFxNM7eqg-1; Mon, 23 Oct 2023 12:18:39 -0400
X-MC-Unique: cAttNStIOn2a7jFxNM7eqg-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-457cd8cf4e6so1258622137.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698077918; x=1698682718;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ut5czDDze7j+1Ijghpb8c61xr1AzZHB+GaM5+Au8mg8=;
        b=RWBVOYcCxfQ4i7nn/q9iLNDmInYnszLAAISYkUsiB1LvPqnxmT1COWut+cNSoqjjD+
         POZI1aHYOg3vzp3FRFfsEwkuQivmgqnU7m/dipNnv3zoGPzErYnhCAs6bZtBbQ2AferG
         hlYkwHnZW18kbzMp9ax1pr3T6YhgYL21hZyWHH/SCrCKh7Izm/EBbE+JJWgHJFPot5wf
         3YORaB7pG1jYEPDagDzJEuvXm/xhNmzPmdtscWDUG1DaSUeMtrUm6udXeNaQEA4FEkYF
         rTv0XjZbF0hiFCMHSlNXFQNgZ81EmkHTKPFx/a+MoEl8cryRWTEtTRrRcuij010//0Cw
         f4+w==
X-Gm-Message-State: AOJu0YxJMJBaR0yDDayUlZvFIy6XxVAz9gV6zrmKMMZa4C/CDlfiApcl
        gF/vVdn6BztqqYGmduci0wMRlfwj1HLykB2dR7hwqVCOlzB/8vx7hID4Wrx6TaotDLmYMhdBnqP
        jP83ChlSVJRYbVkRz2ElItYqE
X-Received: by 2002:a67:c10e:0:b0:457:c9d2:4624 with SMTP id d14-20020a67c10e000000b00457c9d24624mr8598326vsj.31.1698077918691;
        Mon, 23 Oct 2023 09:18:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy1dmvGf+TonaCRs35u3TvwOvOFfRZJMQ/9/d4CfnqFCwWVFMvLeUqOSxJgjtTj2FHYBzaXw==
X-Received: by 2002:a67:c10e:0:b0:457:c9d2:4624 with SMTP id d14-20020a67c10e000000b00457c9d24624mr8598309vsj.31.1698077918408;
        Mon, 23 Oct 2023 09:18:38 -0700 (PDT)
Received: from rh (p200300c93f0047001ec25c15da4a4a7b.dip0.t-ipconnect.de. [2003:c9:3f00:4700:1ec2:5c15:da4a:4a7b])
        by smtp.gmail.com with ESMTPSA id d9-20020a0cf0c9000000b0066d12d1351fsm2925982qvl.143.2023.10.23.09.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 09:18:38 -0700 (PDT)
Date:   Mon, 23 Oct 2023 18:18:32 +0200 (CEST)
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
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v8 03/13] KVM: arm64: PMU: Add a helper to read a vCPU's
 PMCR_EL0
In-Reply-To: <20231020214053.2144305-4-rananta@google.com>
Message-ID: <07c09e70-a337-aa41-f022-7ea43be2c0c0@redhat.com>
References: <20231020214053.2144305-1-rananta@google.com> <20231020214053.2144305-4-rananta@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2023, Raghavendra Rao Ananta wrote:
> From: Reiji Watanabe <reijiw@google.com>
>
> Add a helper to read a vCPU's PMCR_EL0, and use it whenever KVM
> reads a vCPU's PMCR_EL0.
>
> Currently, the PMCR_EL0 value is tracked per vCPU. The following
> patches will make (only) PMCR_EL0.N track per guest. Having the
> new helper will be useful to combine the PMCR_EL0.N field
> (tracked per guest) and the other fields (tracked per vCPU)
> to provide the value of PMCR_EL0.
>
> No functional change intended.
>
> Signed-off-by: Reiji Watanabe <reijiw@google.com>
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Sebastian Ott <sebott@redhat.com>

