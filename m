Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA5580F950
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377329AbjLLV1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbjLLV1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:27:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AEFFD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:27:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82447C433C7;
        Tue, 12 Dec 2023 21:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702416430;
        bh=dswbdDQkq9R1rqLEQPK78MDzN2SBMjw7O1v1jhL3dU4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=r5Q7DnGGEGhJChFt9UzIVBp28k4PNZQGG3QDcSIoEbRCqDHkk1/x+AZynmP5SKQy1
         8sYavtfW2mETOwNUcbgsiTi7SIbNF6x5Ld7NVxdgKyyCmZN+CVgSiaXpuacBLP/D8a
         YJSgzrt9VlXDXRA4oiQXbfmeM9SgZzYXvffVfDRGO5QsiI7Ix2HPCiCWe7IWC03RJZ
         uyNrfJoL/abXRAV95IvqkTJHRlHFzsL+c2rKHGYdb+k0G1U8E3w9/zBGSyTRKPVe6y
         qcqiN7g7G7hry8Y3pkrVhlnRxEp8/DdQop2rAkqd3TuohbEzDwkKzjV4k8Qbk2FYbV
         nUEXOkCGRFvSg==
Date:   Tue, 12 Dec 2023 15:27:07 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2 1/6] PCI/ASPM: Add locked helper for enabling link
 state
Message-ID: <20231212212707.GA1021099@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p59q3D7u01ECsgRUgkDkTkchV-Gv+q=TMFcC44_tOs51Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 11:48:27AM +0800, Kai-Heng Feng wrote:
> On Fri, Dec 8, 2023 at 4:47 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> ...

> > I hope we can obsolete this whole idea someday.  Using pci_walk_bus()
> > in qcom and vmd to enable ASPM is an ugly hack to work around this
> > weird idea that "the OS isn't allowed to enable more ASPM states than
> > the BIOS did because the BIOS might have left ASPM disabled because it
> > knows about hardware issues."  More history at
> > https://lore.kernel.org/linux-pci/20230615070421.1704133-1-kai.heng.feng@canonical.com/T/#u
> >
> > I think we need to get to a point where Linux enables all supported
> > ASPM features by default.  If we really think x86 BIOS assumes an
> > implicit contract that the OS will never enable ASPM more
> > aggressively, we might need some kind of arch quirk for that.
> 
> The reality is that PC ODM toggles ASPM to workaround hardware
> defects, assuming that OS will honor what's set by the BIOS.
> If ASPM gets enabled for all devices, many devices will break.

That's why I mentioned some kind of arch quirk.  Maybe we're forced to
do that for x86, for instance.  But even that is a stop-gap.

The idea that the BIOS ASPM config is some kind of handoff protocol is
really unsupportable.

Do we have concrete examples of where enabling ASPM for a device that
advertises ASPM support will break something?

Bjorn
