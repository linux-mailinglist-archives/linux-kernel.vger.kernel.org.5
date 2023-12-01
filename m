Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EAD80116F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378706AbjLARIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLARId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:08:33 -0500
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C6CC1;
        Fri,  1 Dec 2023 09:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1701450520; x=1732986520;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=LWxdWq/DOS+9khhxJvYujS6PdOihOZyDd4a2PGV9kvA=;
  b=srJMT7xc+Fvc62twit9fGUpSKTXlJnvtKFcvzhoGFTHfxL6a8gN2sAsG
   TVySOIPUzxqA5u4sfWdreiQvanPkMLnXiZHsxlUW6CELrmTPSR21XJlLE
   RklBfKPLkpg2zlZpf6bMqDpwaJG0Zi2rk1TslbDDqhZW6GFxYtn17yoYL
   0=;
X-IronPort-AV: E=Sophos;i="6.04,242,1695686400"; 
   d="scan'208";a="366070872"
Subject: RE: [PATCH 0/2] KVM: xen: update shared_info when long_mode is set
Thread-Topic: [PATCH 0/2] KVM: xen: update shared_info when long_mode is set
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 17:08:37 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
        by email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com (Postfix) with ESMTPS id C88C24964F;
        Fri,  1 Dec 2023 17:08:33 +0000 (UTC)
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:28276]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.32.35:2525] with esmtp (Farcaster)
 id caf748da-6362-4926-9a93-c13b544c9c90; Fri, 1 Dec 2023 17:08:33 +0000 (UTC)
X-Farcaster-Flow-ID: caf748da-6362-4926-9a93-c13b544c9c90
Received: from EX19D032EUC003.ant.amazon.com (10.252.61.137) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 1 Dec 2023 17:08:32 +0000
Received: from EX19D032EUC002.ant.amazon.com (10.252.61.185) by
 EX19D032EUC003.ant.amazon.com (10.252.61.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 1 Dec 2023 17:08:32 +0000
Received: from EX19D032EUC002.ant.amazon.com ([fe80::e696:121c:a227:174]) by
 EX19D032EUC002.ant.amazon.com ([fe80::e696:121c:a227:174%3]) with mapi id
 15.02.1118.040; Fri, 1 Dec 2023 17:08:32 +0000
From:   "Durrant, Paul" <pdurrant@amazon.co.uk>
To:     Sean Christopherson <seanjc@google.com>,
        Paul Durrant <paul@xen.org>
CC:     David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Index: AQHaJEOuWnzn0NGSpk+GH7VJCEKIN7CUozuAgAAF5dA=
Date:   Fri, 1 Dec 2023 17:08:32 +0000
Message-ID: <a0c99edd584b47ce8f9f8aff86b2a568@amazon.co.uk>
References: <20231201104536.947-1-paul@xen.org> <ZWoNzzYiZtloNQiv@google.com>
In-Reply-To: <ZWoNzzYiZtloNQiv@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.106.82.12]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Sean Christopherson <seanjc@google.com>
> Sent: 01 December 2023 16:46
> To: Paul Durrant <paul@xen.org>
> Cc: David Woodhouse <dwmw2@infradead.org>; Paolo Bonzini <pbonzini@redhat=
.com>; Thomas Gleixner
> <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>; Borislav Petkov <bp=
@alien8.de>; Dave Hansen
> <dave.hansen@linux.intel.com>; x86@kernel.org; H. Peter Anvin <hpa@zytor.=
com>; kvm@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: RE: [EXTERNAL] [PATCH 0/2] KVM: xen: update shared_info when lon=
g_mode is set
>=20
> CAUTION: This email originated from outside of the organization. Do not c=
lick links or open
> attachments unless you can confirm the sender and know the content is saf=
e.
>=20
>=20
>=20
> On Fri, Dec 01, 2023, Paul Durrant wrote:
> > From: Paul Durrant <pdurrant@amazon.com>
> >
> > This series is based on my v9 of my "update shared_info and vcpu_info
> > handling" series [1] and fixes an issue that was latent before the
> > "allow shared_info to be mapped by fixed HVA" patch of that series allo=
wed
> > a VMM to set up shared_info before the VM booted and then leave it alon=
e.
>=20
> Uh, what?   If this is fixing an existing bug then it really shouldn't ta=
ke a
> dependency on a rather large and non-trivial series.  If the bug can only=
 manifest
> as a result of said series, then the fix absolutely belongs in that serie=
s.
>=20

There's been radio silence on that series for a while so I was unsure of th=
e status.

> This change from patch 1 in particular:
>=20
>  -static int kvm_xen_shared_info_init(struct kvm *kvm, u64 addr, bool add=
r_is_gfn)
>  +static int kvm_xen_shared_info_init(struct kvm *kvm)
>=20
> practically screams for inclusion in that series which does:
>=20
>  -static int kvm_xen_shared_info_init(struct kvm *kvm, gfn_t gfn)
>  +static int kvm_xen_shared_info_init(struct kvm *kvm, u64 addr, bool add=
r_is_gfn)
>=20
> Why not get the code right the first time instead of fixing it up in a co=
mpletely
> different series?

Sure, I can fold it in.

  Paul

