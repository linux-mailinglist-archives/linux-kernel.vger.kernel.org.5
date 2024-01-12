Return-Path: <linux-kernel+bounces-24924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F03D82C4D1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15FD02858F8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D57A17540;
	Fri, 12 Jan 2024 17:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhsvjCmA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ED722601;
	Fri, 12 Jan 2024 17:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E37C433F1;
	Fri, 12 Jan 2024 17:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705081026;
	bh=kyspuGF+/jomofVPFKqvjOWn53WkC65k3SpM8uRR2V8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YhsvjCmAGkzhLHpefGxQfZI0s9oyOxD4Xx3IegbwDSErHF+O8QvdO5G7G2rOR1Bpv
	 zdO3dQtzEnJsHDG/RiTpxMPc8Afq87IDF36FFm2/rt/AUf67ykCEEZ+xXtHh8xMst0
	 32IzMtpxyANQFfmzij4zEnoCCauAKE69fsPUq3fAyuvNwgH7NHi0G300bDDDjKoCM7
	 jty4ce++AsFyIkuGZrdSv2wtQTTVvv+YeweOAfBw/1CCKQvy1j2C9ayZ64UTQ7K2uD
	 UJWhOrDdHekwwQmQYUnSbw7xqct69HaXS5DvQok/jNREfTNyhXq3H+jiy3VNxxolus
	 4jATA4s9igCFQ==
Date: Fri, 12 Jan 2024 11:37:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Ben Chuang <benchuanggli@gmail.com>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: GL975x: Mask rootport's replay
 timer timeout during suspend
Message-ID: <20240112173704.GA2272968@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p7ZwYNau1c=SDpGd+cqP2qO_7km9Q3-bow-Jqzo6STVFA@mail.gmail.com>

On Fri, Jan 12, 2024 at 01:14:42PM +0800, Kai-Heng Feng wrote:
> On Sat, Jan 6, 2024 at 5:19 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Thu, Dec 21, 2023 at 11:21:47AM +0800, Kai-Heng Feng wrote:
> > > Spamming `lspci -vv` can still observe the replay timer timeout error
> > > even after commit 015c9cbcf0ad ("mmc: sdhci-pci-gli: GL9750: Mask the
> > > replay timer timeout of AER"), albeit with a lower reproduce rate.
> >
> > I'm not sure what this is telling me.  By "spamming `lspci -vv`, do
> > you mean that if you run lspci continually, you still see Replay Timer
> > Timeout logged, e.g.,
> >
> >   CESta:        ... Timeout+
> 
> Yes it's logged and the AER IRQ is raised.

IIUC the AER IRQ is the important thing.

Neither 015c9cbcf0ad nor this patch affects logging in
PCI_ERR_COR_STATUS, so the lspci output won't change and mentioning it
here doesn't add useful information.

I'd suggest more specific wording than "spamming `lspci -vv`", e.g.,

  015c9cbcf0ad ("mmc: sdhci-pci-gli: GL9750: Mask the replay timer
  timeout of AER") masks Replay Timer Timeout errors at the GL975x
  Endpoint.  When the Endpoint detects these errors, it still logs
  them in its PCI_ERR_COR_STATUS, but masking prevents it from sending
  ERR_COR messages upstream.

  The Downstream Port leading to a GL975x Endpoint is unaffected by
  015c9cbcf0ad.  Previously, when that Port detected a Replay Timer
  Timeout, it sent an ERR_COR message upstream, which eventually
  caused an AER IRQ, which prevented the system from suspending.

  Mask Replay Timer Timeout errors at the Downstream Port.  The errors
  will still be logged in PCI_ERR_COR_STATUS, but no ERR_COR will be
  sent.

> > 015c9cbcf0ad uses hard-coded PCI_GLI_9750_CORRERR_MASK offset and
> > PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT value, which look like
> > they *could* be PCI_ERR_COR_MASK and PCI_ERR_COR_REP_TIMER, but
> > without the lspci output I can't tell for sure.  If they are, it would
> > be nice to use the generic macros instead of defining new ones so it's
> > easier to analyze PCI_ERR_COR_MASK usage.
> >
> > If 015c9cbcf0ad is updating the generic PCI_ERR_COR_MASK, it should
> > only prevent sending ERR_COR.  It should not affect the *logging* in
> > PCI_ERR_COR_STATUS (see PCIe r6.0, sec 6.2.3.2.2), so it shouldn't
> > affect the lspci output.
> 
> PCI_GLI_9750_CORRERR_MASK is specific to GLI 975x devices, so it
> doesn't conform to generic PCI_ERR_COR_STATUS behavior.

*Could* 015c9cbcf0ad have used the generic PCI_ERR_COR_MASK to
accomplish the same effect?  Is there an advantage to using the
device-specific PCI_GLI_9750_CORRERR_MASK?

If masking via PCI_ERR_COR_MASK would work, that would be much better
because the PCI core can see, manage, and make that visible, e.g., via
sysfs.  The core doesn't do that today, but people are working on it.

> > If 015c9cbcf0ad is actually updating PCI_ERR_COR_MASK, it would be
> > nice to clean that up, too.  And maybe PCI_ERR_COR_REP_TIMER should be
> > masked/restored at the same place for both the Downstream Port and the
> > Endpoint?
> 
> Since PCI_ERR_COR_REP_TIMER is already masked before 015c9cbcf0ad,
> so I didn't think that's necessary.  Do you think it should still be
> masked just to be safe?

Did you mean "PCI_ERR_COR_REP_TIMER is already masked *by*
015c9cbcf0ad"?

If masking PCI_ERR_COR_REP_TIMER using the generic PCI_ERR_COR_MASK in
the GL975x would have the same effect as masking it with
PCI_GLI_9750_CORRERR_MASK, then I think you should *only* use the
generic PCI_ERR_COR_MASK.

No need to do both if the generic one is sufficient.  And I think both
should be done in the same place since they're basically solving the
same problem, just at both ends of the link.

Bjorn

