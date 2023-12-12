Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F1080EDCA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346533AbjLLNiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346569AbjLLNiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:38:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6379BCA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702388297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4IjtSLSS+KMn2n0R4fQtLvtCI4SQNSXOvC4z09ahOFQ=;
        b=QnnrM/ojkQbotVaRI7gB8Obp3cWqBXS+M/DLubLAxsMccXdsu3QAhaD/eJ0nMfSSahs7VV
        V5nmMfxOEitoseQviDMqaPZpq8vF6y8l6UuDOEOxCTXZ4JM3sEezusI+CPhIhgeIBtMPqx
        k2xgasMcfK8U8LPUrh94/JMpPFOk4Uo=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-Z61AYHyKO_ae2mcBocnNtQ-1; Tue, 12 Dec 2023 08:38:16 -0500
X-MC-Unique: Z61AYHyKO_ae2mcBocnNtQ-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-7cb2d8b214dso112083241.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:38:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702388295; x=1702993095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IjtSLSS+KMn2n0R4fQtLvtCI4SQNSXOvC4z09ahOFQ=;
        b=LvFyuSFiHler31BIueJXBxILH6HcsrMDF5k5P+t9KiUKZ27lZXRlZ6wi8BxUycLXIz
         OrfHcNgxV5v/kVwfkQgw10PnM87HZjbTec4N/fbQwZ7HYpxuKzt+SOjTYlNMsiOe+ogy
         lazLQ5aT9Pf63/bOQ7lDIiHgk4YeqbPrchhF6C/ZidArrhmk9RKux1AUAqXmWPcUEtQk
         qQwgFNuJExKXJ94OHjf79v12F+ttIx5AQMqUXS3cG/NS/rlLSGm5A+DlnVx6HzdKp/O4
         9KbxmkX7m9GTTerp1fLs03+xAkov5Tt6WcCLGo3MZXQhMLdmrvz786LdoH7t8GQSc4lo
         zpYQ==
X-Gm-Message-State: AOJu0YyBPrP2D6SnnaHwa3FXZc6nS8cIsZlj72ZBvZUQ1nQnwUyry8WE
        kAGtFj/XIAlds9tVTbwZVvf/Qt7auguf5AgaU9KunTNBalebaKCOoSWK+ZD7IiAmTB3mZAj+czC
        tISH+r1z3CJdezXHbqy9KOvziTdvQxGvU+Z5JLjHMZIuyAwkq
X-Received: by 2002:a05:6102:954:b0:464:a4b9:5ca2 with SMTP id a20-20020a056102095400b00464a4b95ca2mr4133765vsi.43.1702388295546;
        Tue, 12 Dec 2023 05:38:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoi0rzc6o7Gt4+TFEGhMVoc3vZ6tzwUFixtpjFgOfHf47vt6vk5agyXIEXqqQZSIqeGr8AylCCZagp/mgF4KI=
X-Received: by 2002:a05:6102:954:b0:464:a4b9:5ca2 with SMTP id
 a20-20020a056102095400b00464a4b95ca2mr4133761vsi.43.1702388295319; Tue, 12
 Dec 2023 05:38:15 -0800 (PST)
MIME-Version: 1.0
References: <20230512233127.804012-1-seanjc@google.com> <20230512233127.804012-2-seanjc@google.com>
 <cfed942fc767fa7b2fabc68a3357a7b95bd6a589.camel@amazon.com>
 <871qbud5f9.fsf@email.froward.int.ebiederm.org> <a02b40d3d9ae5b3037b9a9d5921cfb0144ab5610.camel@amazon.com>
 <7e30cfc2359dfef39d038e3734f7e5e3d9e82d68.camel@amazon.com>
 <87wmtk9u46.fsf@email.froward.int.ebiederm.org> <cf9e15bf3da411ada1c5b2bbdbfdea836029a5e1.camel@amazon.com>
In-Reply-To: <cf9e15bf3da411ada1c5b2bbdbfdea836029a5e1.camel@amazon.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue, 12 Dec 2023 14:38:02 +0100
Message-ID: <CABgObfZKOkUn3++g-YMkv7bsmKU77Y88NPBqt-5XoRJFLXDEFA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] KVM: Use syscore_ops instead of reboot_notifier to
 hook restart/shutdown
To:     "Gowans, James" <jgowans@amazon.com>
Cc:     "Graf (AWS), Alexander" <graf@amazon.de>,
        "seanjc@google.com" <seanjc@google.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        =?UTF-8?B?U2Now7ZuaGVyciwgSmFuIEgu?= <jschoenh@amazon.de>,
        "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
        "atishp@atishpatra.org" <atishp@atishpatra.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "aleksandar.qemu.devel@gmail.com" <aleksandar.qemu.devel@gmail.com>,
        "anup@brainfault.org" <anup@brainfault.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 9:51=E2=80=AFAM Gowans, James <jgowans@amazon.com> =
wrote:
> 1. Does hardware_disable_nolock actually need to be done on *every* CPU
> or would the offlined ones be fine to ignore because they will be reset
> and the VMXE bit will be cleared that way? With cooperative CPU handover
> we probably do indeed want to do this on every CPU and not depend on
> resetting.

Offlined and onlined CPUs are handled via the CPU hotplug state machine,
which calls into kvm_online_cpu and kvm_offline_cpu.

Paolo

