Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEFF79CA80
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjILIqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjILIqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:46:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A42DC1737
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694508326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3hUC4x3FXZvTagHd2cD4t3OZmFD4EPm/rOhyiGmvo8w=;
        b=WrJ/Y6QgUDvKbU/AYHnWU2v0sRosX9XKfH5wsqqzQ9SmPY99v6zzAleQlFO/Z/S3SneFiK
        qxkA1SoCP6vm9vsJuONRGGXj+GePoZf0DYxs4FqM5yQONj6PENxVCGf4cQ2UWyLN3Yn6hp
        um2ryHmERIU78O911yEhLXWxl1ScZRw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-OVOtXyATPW6JN3S370MR1w-1; Tue, 12 Sep 2023 04:45:25 -0400
X-MC-Unique: OVOtXyATPW6JN3S370MR1w-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9a9cd336c9cso133945966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694508324; x=1695113124;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3hUC4x3FXZvTagHd2cD4t3OZmFD4EPm/rOhyiGmvo8w=;
        b=k7hdmJ9cTHWqmKjhv74kKY7eeRKTkx/RkIgEGPakXRdEExt5xhDP5V+NYgScesz+6B
         NEijHMzLcINj19MecSbIKu/PQsfv+yEUFATm5mF2gEWUO0GP15xXCVWkkalRpfz1kNZy
         cDEM9N/YWxifGnmhV9wWlXP2cuT10O0D1hHeKvLX6/Y690uUHCc1U50Og/aPpfZreYBR
         h2y63BJyGkfuV9IOo12xdoyFRskc80kGc2IVzTFTZOy3KpDgC0unCbfFJhQFsdVm4U0O
         fJidUSNcvIELwuSPlCzSbXPdDYmEJTks+KahxfL0vyYXQAts8HB8Awrli7i5JmPXQBr2
         LOBA==
X-Gm-Message-State: AOJu0Yxh5BG5lm/+GONsWW8ksoKsGkqY2yuQ/d+vG40nGztqfymeoTwy
        yl70qXYPpuBzlKMrYoOTgmQT1xu0eMDU1Mw0yhiSJJltglCQDtXJVcMrJwY6XJcCdXcaETcMd4q
        AihalqqKsUyacEpTwb7d4s98k
X-Received: by 2002:a17:906:254:b0:9a5:a701:2b94 with SMTP id 20-20020a170906025400b009a5a7012b94mr9196361ejl.7.1694508323972;
        Tue, 12 Sep 2023 01:45:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpiSb88bPEZUnnVfXGKy7ahcM0UPN8GF+UlMWw3spQWZk++q+dCMlUOm8PacoxmU0GsjVmFg==
X-Received: by 2002:a17:906:254:b0:9a5:a701:2b94 with SMTP id 20-20020a170906025400b009a5a7012b94mr9196343ejl.7.1694508323670;
        Tue, 12 Sep 2023 01:45:23 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-231.dyn.eolo.it. [146.241.249.231])
        by smtp.gmail.com with ESMTPSA id y22-20020a170906449600b0099bc8db97bcsm6473980ejo.131.2023.09.12.01.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 01:45:23 -0700 (PDT)
Message-ID: <2c532d4594ca0cacdc0cfc5d1f5d55d5d758dc1b.camel@redhat.com>
Subject: Re: [net PATCH] octeon_ep: fix tx dma unmap len values in SG
From:   Paolo Abeni <pabeni@redhat.com>
To:     Shinas Rasheed <srasheed@marvell.com>, horms@kernel.org
Cc:     aayarekar@marvell.com, davem@davemloft.net, edumazet@google.com,
        egallen@redhat.com, hgani@marvell.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, mschmidt@redhat.com,
        netdev@vger.kernel.org, sburla@marvell.com, sedara@marvell.com,
        vburru@marvell.com, vimleshk@marvell.com
Date:   Tue, 12 Sep 2023 10:45:21 +0200
In-Reply-To: <20230912070400.2136431-1-srasheed@marvell.com>
References: <20230911180113.GA113013@kernel.org>
         <20230912070400.2136431-1-srasheed@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-12 at 00:04 -0700, Shinas Rasheed wrote:
> This change is required in octep_iq_process_completions, as given in the =
patch,
> since the scatter gather pointer lengths arrive as big-endian in hardware=
.

I guess Simon intended asking about octep_iq_free_pending(), and AFAICT
your reply confirm that the change is required there, too.

Additionally the changelog really need to be expanded. I don't
understand how this change relates to endianess: if the ring format is
big endian I expect some be16_to_cpu(len) instead of complement-to-4 of
indexes.

Please clarify and expand the changelog, thanks!

Paolo

