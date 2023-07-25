Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFD4760D77
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjGYIpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjGYIoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:44:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E37E2694
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690274562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E/lGM3AFGn4fMjg440JiVDWQxDq2/CsLGdFzbi2mu8k=;
        b=J5kSUerwYgo4/lTzAK6ornThFkcmlLfM+ouLp3ZIJqw34BSnPX6MS8+3C0lQhZte/wfOXv
        MYrqYPlJ4zZmyAg/LPkmm1V3kbdK0MepweIZzSRykFEkyk6h7CJynmZH6bD+UDSUB9lBH+
        Qdct/rVaaVfYGKDVyrva1pZZHqky0UU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-ApVc3WbQNXuuph82yZUSTA-1; Tue, 25 Jul 2023 04:42:41 -0400
X-MC-Unique: ApVc3WbQNXuuph82yZUSTA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-993d7ca4607so342065666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690274559; x=1690879359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/lGM3AFGn4fMjg440JiVDWQxDq2/CsLGdFzbi2mu8k=;
        b=EKP/yI07y7uZLHsqo9VgD3C8gy4+HhEYH18MJ4eKnzpGP3iVjkR3IHTarUwwzEdlum
         DIqtTK82gBsmc6C1646jemj/TPYxU/TP4+G7vYdxFOTG6QtqRRsv2JLEqkhAQiAYmW1/
         7MFxaxcthZvntdKduImvqckTAP++Xt6ilEpwWP0NvKRUadHvq0dbvEvpPdp/NBtDzgZn
         2/oKwTX4pFK/wa1zIzIX5llOGPvNDcuWIdu1n1JC65zCSkn1Su+cKLfTAHH3bR0FSe0E
         LgOy1uayDPyr5KhIY+DPQ1+NjKyHvJFBkduclO3sUhfAUF+oPLixax7TDcAuCk952KNB
         Co5Q==
X-Gm-Message-State: ABy/qLbZ2WkdS9gwjcWY8A58zqY6WYcJf2XcXgJqqK4gDI1ekODU+DAx
        EhI1Z7yjIYMKIstKztLsmml8w4DPP4AuVgXLQle9rkV9+jop5fmXGmK4l6ar41d9zmrHknQBHys
        VmYTpdJnmU94X6CaIZpl8qz13h4/3wtyP
X-Received: by 2002:a17:906:cc49:b0:98f:5640:16a with SMTP id mm9-20020a170906cc4900b0098f5640016amr12404162ejb.53.1690274559332;
        Tue, 25 Jul 2023 01:42:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFT8gkR9kPbQttomndHJiJR3D8A95upZF6W+dEQNzOD6/93XYMy+W6KX9P6z63JwSAMCrdeZA==
X-Received: by 2002:a17:906:cc49:b0:98f:5640:16a with SMTP id mm9-20020a170906cc4900b0098f5640016amr12404149ejb.53.1690274559025;
        Tue, 25 Jul 2023 01:42:39 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id jp7-20020a170906f74700b009937dbabbd5sm7840352ejb.220.2023.07.25.01.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:42:38 -0700 (PDT)
Date:   Tue, 25 Jul 2023 10:42:37 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     Woody Suwalski <terraluna977@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, mst@redhat.com
Subject: Re: [PATCH] hack to debug acpiphp crash
Message-ID: <20230725104237.0c8d0dc1@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230725100644.6138efb6@imammedo.users.ipa.redhat.com>
References: <11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com>
        <20230724135902.2217991-1-imammedo@redhat.com>
        <92150d8d-8a3a-d600-a996-f60a8e4c876c@gmail.com>
        <20230725100644.6138efb6@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 10:06:44 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> PS:
> What happens is that on resume firmware (likely EC),
> issues ACPI bus check on root ports which (bus check) is
> wired to acpiphp module (though pciehp module was initialized
> at boot to manage root ports), it's likely firmware bug.
> 
> I'd guess the intent behind this was to check if PCIe devices
> were hotplugged while laptop has been asleep, and for
> some reason they didn't use native PCIe hotplug to handle that. 
> However looking at laptop specs you can't hotplug PCIe
> devices via external ports. Given how old laptop is
> it isn't going to be fixed, so we would need a workaround
> or fixup DSDT to skip buscheck.
> 
> The options I see is to keep old kernel as for such case,
> or bail out early from bus check/enable_slot since root port
> is managed by pciehp module (and let it handle hotplug).

scratch all of above out (it's wrong). Looking at DSDT
firmware sends Notify(rpxx, 2 /* Wake */) event. Which
according to spec needs to be handed down to the native
device driver.


