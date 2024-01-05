Return-Path: <linux-kernel+bounces-18364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8719825C17
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9567B285991
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5030B360AB;
	Fri,  5 Jan 2024 21:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGib/U3q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9172836093;
	Fri,  5 Jan 2024 21:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C739EC433C8;
	Fri,  5 Jan 2024 21:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704489554;
	bh=r6VpZcl/+5qdd8NJeDG6ntKCj6UANg5Stff9+hLiay4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZGib/U3q7WTcWPewnv3atSj5vklmPYakWLzZQFtcpnu/IPM7p5XUS0TQNUxSJdRuL
	 L4TBxBjrTf6J26ZsegSXUNJEJWyWjzcL3eWpnna/55cOzMZpjwuTkn8izjaABUWTte
	 Iz7PCnbHnfW1Z3LIAAKSBZDPLsajAiCZsu35dOdnCvMJVH1rbvpn26fNwXXEX6cMCJ
	 DwqmLeA7RFRz4E99HjrSwDSFLlRivldTeKAgRYTJYm6Rrk2qP2G83k0lJj3tnUGyEB
	 SUwgt2RySz/E7QJjQYj+NFsvOW8FEJpx67fW4hCjPr2/G2k7VoSMCglKEUhtbQ+nHV
	 rqIPqJKK1SGew==
Date: Fri, 5 Jan 2024 15:19:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Ben Chuang <benchuanggli@gmail.com>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: GL975x: Mask rootport's replay
 timer timeout during suspend
Message-ID: <20240105211911.GA1867400@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221032147.434647-1-kai.heng.feng@canonical.com>

On Thu, Dec 21, 2023 at 11:21:47AM +0800, Kai-Heng Feng wrote:
> Spamming `lspci -vv` can still observe the replay timer timeout error
> even after commit 015c9cbcf0ad ("mmc: sdhci-pci-gli: GL9750: Mask the
> replay timer timeout of AER"), albeit with a lower reproduce rate.

I'm not sure what this is telling me.  By "spamming `lspci -vv`, do
you mean that if you run lspci continually, you still see Replay Timer
Timeout logged, e.g.,

  CESta:	... Timeout+

015c9cbcf0ad uses hard-coded PCI_GLI_9750_CORRERR_MASK offset and
PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT value, which look like
they *could* be PCI_ERR_COR_MASK and PCI_ERR_COR_REP_TIMER, but
without the lspci output I can't tell for sure.  If they are, it would
be nice to use the generic macros instead of defining new ones so it's
easier to analyze PCI_ERR_COR_MASK usage.

If 015c9cbcf0ad is updating the generic PCI_ERR_COR_MASK, it should
only prevent sending ERR_COR.  It should not affect the *logging* in
PCI_ERR_COR_STATUS (see PCIe r6.0, sec 6.2.3.2.2), so it shouldn't
affect the lspci output.

> Such AER interrupt can still prevent the system from suspending, so let
> root port mask and unmask replay timer timeout during suspend and
> resume, respectively.

015c9cbcf0ad looks like it masks PCI_ERR_COR_REP_TIMER in the gl975x
Endpoint, while this patch masks it in the upstream bridge (which
might be either a Root Port or a Switch Downstream Port, so the
subject and this sentence are not quite right).

015c9cbcf0ad says it is related to a hardware defect, and maybe this
patch is also (mention it if so).  Both patches can prevent ERR_COR
messages and the eventual AER interrupt, depending on whether the
Downstream Port or the Endpoint detects the Replay Timer Timeout.
Maybe this should have a Fixes: tag for 015c9cbcf0ad to try to keep
these together?

If 015c9cbcf0ad is actually updating PCI_ERR_COR_MASK, it would be
nice to clean that up, too.  And maybe PCI_ERR_COR_REP_TIMER should be
masked/restored at the same place for both the Downstream Port and the
Endpoint?

> +#ifdef CONFIG_PCIEAER
> +static void mask_replay_timer_timeout(struct pci_dev *pdev)
> +{
> +	struct pci_dev *parent = pci_upstream_bridge(pdev);
> +	u32 val;
> +
> +	if (!parent || !parent->aer_cap)
> +		return;
> +
> +	pci_read_config_dword(parent, parent->aer_cap + PCI_ERR_COR_MASK, &val);
> +	val |= PCI_ERR_COR_REP_TIMER;
> +	pci_write_config_dword(parent, parent->aer_cap + PCI_ERR_COR_MASK, val);
> +}
> +
> +static void unmask_replay_timer_timeout(struct pci_dev *pdev)
> +{
> +	struct pci_dev *parent = pci_upstream_bridge(pdev);
> +	u32 val;
> +
> +	if (!parent || !parent->aer_cap)
> +		return;
> +
> +	pci_read_config_dword(pdev, parent->aer_cap + PCI_ERR_COR_MASK, &val);
> +	val &= ~PCI_ERR_COR_REP_TIMER;

I think I would save the previous PCI_ERR_COR_REP_TIMER value and
restore it here, so it is preserved if there is ever a generic
interface via sysfs or similar to manage correctable error masking.

> +	pci_write_config_dword(pdev, parent->aer_cap + PCI_ERR_COR_MASK, val);
> +}

