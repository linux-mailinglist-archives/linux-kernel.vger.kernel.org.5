Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B029278C6CA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236749AbjH2OEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236833AbjH2OEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:04:02 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D913EC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:03:58 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1c134602a55so942464fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693317838; x=1693922638;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V1y5zk2EZ7NA4Kw0iiDlONwTcc+fACO/gl76TUULgNc=;
        b=is5cU6xzg2qXe2zjt8TMEevTI6jNeJEFj5O+UDLlko4aZsviv0no641Z14bDj+x00i
         lRv8mki1VZnQEnSMiD+//Qbhr0HqFfm8B5bjlWAUbaSH2BGbhQO/ti4cn8OjUDVKMPdS
         MEuz30tuHPHrQIvq1VQh9sAvNsVN0O+t/xy4kcOQKAbLg/Hs87ZO7IMSz2yShmWThMaj
         OlQa7odfGgtPoVk25ro90V4NU0nkeRC2PAb4LD4WVGclMRk/Akf2PghTi0sQe556ojh5
         zMrRLu3f5jm7r/FKyhqt8aYXSJvPX5LtbmMJOaySz/u8uEhXMtUF4CcwaScZv9if1iEW
         epaw==
X-Gm-Message-State: AOJu0YwxdI7a2VzWv3s4HktvuwokXj8f4IX+dRO5Qa54Dq9FzFG9xTeG
        G7e7TpuGY4WA05aOvHRuBRuByYoiPs3YOXI/nuI=
X-Google-Smtp-Source: AGHT+IH/CyJjOo+UVlcCg78L0YPsOl/JFw2u9OyZRcGECHUs7lAGjeP19e+8/aqcPpc1mjLUmr5N0kcPCv9w/FI/CRA=
X-Received: by 2002:a4a:e699:0:b0:573:4a72:6ec with SMTP id
 u25-20020a4ae699000000b005734a7206ecmr10884203oot.1.1693317837741; Tue, 29
 Aug 2023 07:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <c7a05a44-c0be-46c2-a21d-b242524d482b@roeck-us.net>
 <CAJZ5v0jASjc_RYp-SN5KMGJXDv8xbMOqJscLF3wG8rdE2_KJGw@mail.gmail.com> <3fd2e62d-0aa9-1098-3eb3-ed45460a3580@intel.com>
In-Reply-To: <3fd2e62d-0aa9-1098-3eb3-ed45460a3580@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 29 Aug 2023 16:03:46 +0200
Message-ID: <CAJZ5v0hnNK4O_HyinvTp01YxXR7V4vzpMhf85yW9M2=52-O2Fg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: Move MWAIT quirk out of acpi_processor.c
To:     "Wilczynski, Michal" <michal.wilczynski@intel.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        andriy.shevchenko@intel.com, artem.bityutskiy@linux.intel.com,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, lenb@kernel.org, jgross@suse.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: multipart/mixed; boundary="00000000000035fcf60604104842"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000035fcf60604104842
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2023 at 3:58=E2=80=AFPM Wilczynski, Michal
<michal.wilczynski@intel.com> wrote:
>
>
>
> On 8/29/2023 3:54 PM, Rafael J. Wysocki wrote:
> > On Tue, Aug 29, 2023 at 3:44=E2=80=AFPM Guenter Roeck <linux@roeck-us.n=
et> wrote:
> >> On Mon, Jul 10, 2023 at 05:03:29PM +0300, Michal Wilczynski wrote:
> >>> Commit 2a2a64714d9c ("ACPI: Disable MWAIT via DMI on broken Compal bo=
ard")
> >>> introduced a workaround for MWAIT for a specific x86 system.
> >>>
> >>> Move the code outside of acpi_processor.c to acpi/x86/ directory for
> >>> consistency and rename the functions associated with it, so their nam=
es
> >>> start with "acpi_proc_quirk_" to make the goal obvious.
> >>>
> >>> No intentional functional impact.
> >>>
> >> Except for:
> >>
> >> ia64-linux-ld: drivers/acpi/acpi_processor.o: in function `acpi_early_=
processor_control_setup':
> >> acpi_processor.c:(.init.text+0x712): undefined reference to `acpi_proc=
_quirk_mwait_check'
> >> ia64-linux-ld: drivers/acpi/processor_pdc.o: in function `acpi_early_p=
rocessor_set_pdc':
> >> processor_pdc.c:(.init.text+0x72): undefined reference to `acpi_proc_q=
uirk_mwait_check'
> >>
> >> which breaks all ia64 builds.
> >>
> >> Time to retire that architecture yet ? No one but me seems to even
> >> build test it.
> > Including 0-day it seems.  This had been in linux-next for several week=
s.
> >
> > Michal, can you have a look at this please?
>
> Hi,
> I'll take a look and get back to you with a fix,

Actually, if I'm not mistaken, the attached patch should be sufficient.

--00000000000035fcf60604104842
Content-Type: text/x-patch; charset="US-ASCII"; name="acpi-processor-fix-ia64-buil.patch"
Content-Disposition: attachment; 
	filename="acpi-processor-fix-ia64-buil.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_llwdpmj00>
X-Attachment-Id: f_llwdpmj00

LS0tCiBkcml2ZXJzL2FjcGkvaW50ZXJuYWwuaCB8ICAgMTQgKysrKy0tLS0tLS0tLS0KIDEgZmls
ZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKSW5kZXg6IGxpbnV4
LXBtL2RyaXZlcnMvYWNwaS9pbnRlcm5hbC5oCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LXBtLm9yaWcv
ZHJpdmVycy9hY3BpL2ludGVybmFsLmgKKysrIGxpbnV4LXBtL2RyaXZlcnMvYWNwaS9pbnRlcm5h
bC5oCkBAIC0xNDgsOCArMTQ4LDExIEBAIGludCBhY3BpX3dha2V1cF9kZXZpY2VfaW5pdCh2b2lk
KTsKICNpZmRlZiBDT05GSUdfQVJDSF9NSUdIVF9IQVZFX0FDUElfUERDCiB2b2lkIGFjcGlfZWFy
bHlfcHJvY2Vzc29yX2NvbnRyb2xfc2V0dXAodm9pZCk7CiB2b2lkIGFjcGlfZWFybHlfcHJvY2Vz
c29yX3NldF9wZGModm9pZCk7Ci0KKyNpZmRlZiBDT05GSUdfWDg2CiB2b2lkIGFjcGlfcHJvY19x
dWlya19td2FpdF9jaGVjayh2b2lkKTsKKyNlbHNlCitzdGF0aWMgaW5saW5lIHZvaWQgYWNwaV9w
cm9jX3F1aXJrX213YWl0X2NoZWNrKHZvaWQpIHt9CisjZW5kaWYKIGJvb2wgcHJvY2Vzc29yX3Bo
eXNpY2FsbHlfcHJlc2VudChhY3BpX2hhbmRsZSBoYW5kbGUpOwogI2Vsc2UKIHN0YXRpYyBpbmxp
bmUgdm9pZCBhY3BpX2Vhcmx5X3Byb2Nlc3Nvcl9jb250cm9sX3NldHVwKHZvaWQpIHt9Cg==
--00000000000035fcf60604104842--
