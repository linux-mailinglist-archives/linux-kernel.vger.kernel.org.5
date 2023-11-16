Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4017EE115
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345057AbjKPNJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjKPNJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:09:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE721181
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 05:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700140143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MonhjC3WXqcY3h7WdCFO745+80UlcrRmMeuYZtAtOeE=;
        b=L7zukpE//aWia7CVJrBb6W/LTdCocR7Ztj4wPDYdE+lHUPNuXt619qjPsEEwqQwRYLJXA7
        3ySFYOpU3sXT613w6Soo476+dy6I75q+/fFPhWMda70iUVGj/zFEUqcVqKy7Q/it4IVBQx
        FTMTtjW88Q1oIhPzJ1TfjON2zcMF/1E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-Xo8IBKGHMtuhjaOTJw4t7w-1; Thu,
 16 Nov 2023 08:09:01 -0500
X-MC-Unique: Xo8IBKGHMtuhjaOTJw4t7w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D054F3C11A0C;
        Thu, 16 Nov 2023 13:09:00 +0000 (UTC)
Received: from localhost (unknown [10.39.193.127])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2758640C6EB9;
        Thu, 16 Nov 2023 13:08:59 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Jianyong Wu <jianyong.wu@arm.com>, maz@kernel.org,
        james.morse@arm.com, will@kernel.org
Cc:     rmk@armlinux.org.uk, salil.mehta@huawei.com,
        suzuki.poulose@arm.com, oliver.upton@linux.dev,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, justin.he@arm.com,
        jianyong.wu@arm.com
Subject: Re: [PATCH] arm64/kvm: Introduce feature extension for SMCCC filter
In-Reply-To: <20231116114152.912344-1-jianyong.wu@arm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
References: <20231116114152.912344-1-jianyong.wu@arm.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date:   Thu, 16 Nov 2023 14:08:58 +0100
Message-ID: <877cmhq1zp.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16 2023, Jianyong Wu <jianyong.wu@arm.com> wrote:

> 821d935c87b introduces support for userspace SMCCC filtering, but lack
> of a way to tell userspace if we have this feature. Add a corresponding
> feature extension can resolve this issue.
>
> For example, the incoming feature Vcpu Hotplug needs the SMCCC filter.
> As there is no way to check this feature, VMM will run into error when
> it calls this feature on an old kernel. It's bad for backward compatible.

Can't you simply query via KVM_HAS_DEVICE_ATTR whether the SMCCC
filtering controls exist?

>
> Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
> ---
>  Documentation/virt/kvm/api.rst | 3 ++-
>  arch/arm64/kvm/arm.c           | 1 +
>  include/uapi/linux/kvm.h       | 1 +
>  3 files changed, 4 insertions(+), 1 deletion(-)
>

