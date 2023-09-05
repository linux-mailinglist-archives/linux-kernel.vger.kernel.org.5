Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C5D793081
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244061AbjIEU5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbjIEU52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:57:28 -0400
X-Greylist: delayed 376 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 13:57:24 PDT
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B2FAC;
        Tue,  5 Sep 2023 13:57:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C655C433CD;
        Tue,  5 Sep 2023 20:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693947067;
        bh=j4VZbhneezS5ukKmIZ2uZimOa3neoOXs4OmnssGUIZo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SRMIreR3MbvlHVssKklNjRJUN8OK5Yy/okWw4R0X5iuACktEViVghv9GG99706CeT
         W2gEdQexSVPrWX8Mya07w/Bc9sqJe1TGfUDJV4JOSZcydeOZEl9l2y89/bG1dtCX2m
         EjKLQyaOaXfYiKMy2wDm72jK5vNGv+gWg3gX0BAUCN2Ouqrc8o8gtZmO3+UzJA0dnL
         /5Qp+N03IBytPGFxncdP9anpTypbGmI6QUYwpKNnGOxepNLoOJa103PlKVNf5gmQeX
         8+g4qT6wZOTQKdXonB9tZjiuHp1wNl1wUWmttVnTjVQ8PoALdWgXAv2NbUpqVEM3mp
         NtsZIJL01cUvQ==
Date:   Tue, 5 Sep 2023 15:51:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     hdegoede@redhat.com, bhelgaas@google.com, rafael@kernel.org,
        Shyam-sundar.S-k@amd.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Iain Lane <iain@orangesquash.org.uk>
Subject: Re: [PATCH v16 3/3] platform/x86/amd: pmc: Don't let PCIe root ports
 go into D3
Message-ID: <20230905205105.GA191110@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829171212.156688-4-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc Hans]

On Tue, Aug 29, 2023 at 12:12:12PM -0500, Mario Limonciello wrote:
> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> changed pci_bridge_d3_possible() so that any vendor's PCIe ports
> from modern machines (>=2015) are allowed to be put into D3.
> 
> Iain reports that USB devices can't be used to wake a Lenovo Z13
> from suspend. This is because the PCIe root port has been put
> into D3 and AMD's platform can't handle USB devices waking from
> a hardware sleep state in this case.

Can you be specific in the subject and commit log about whether "D3"
refers to "D3hot", "D3cold", or both?  It's probably obvious to PM
folks, but it's always a stumbling block for me.

I assume "can't handle USB devices waking" does not refer to a problem
with the USB adapter and whatever mechanism it uses to send a wakeup
event to request that power be turned on, but rather it means that the
wakeup event doesn't get propagated through the Root Port?

Is this actually specific to USB devices?  Or could a NIC below the
Root Port suffer the same problem when a wake-on-lan packet causes it
to send a wakeup event?  It seems like we've had this conversation
before; sorry to ask the same questions again.

If it's not specific to USB, I would say something like "when the Root
Port is in D3cold, wakeup events from devices below it are lost" (or
whatever the actual problem is).

> This problem only occurs on Linux, and only when the AMD PMC driver
> is utilized to put the device into a hardware sleep state.

Is the AMD PMC driver doing something magic that can't be done via
other power management paths?  That's what "only when the AMD PMC
driver is utilized" suggests.  But if the problem occurs when the Root
Port is put into D3cold via *any* means, just say that.

And if you can say a specific PCI power state instead of "hardware
sleep state", that would be good, too.

> Comparing
> the behavior on Windows and Linux, Windows doesn't put the root ports
> into D3.
> 
> A variety of approaches were discussed to change PCI core to handle this
> case generically but no consensus was reached. To limit the scope of
> effect only to the affected machines introduce a workaround into the
> amd-pmc driver to only apply to the PCI root ports in affected machines
> when going into hardware sleep.

> +/* only allow PCIe root ports with a LPS0 constraint configured to go to D3 */
> +static int amd_pmc_rp_wa(struct amd_pmc_dev *pdev)
> +{
> +	struct pci_dev *pci_dev = NULL;
> +
> +	while ((pci_dev = pci_get_device(PCI_VENDOR_ID_AMD, PCI_ANY_ID, pci_dev))) {

I hate to add more uses of pci_get_device() because it doesn't account
for hot-added devices.  Maybe there's no need to support hot-add of
AMD Root Ports, but that's not obvious to readers here.

One mechanism to avoid pci_get_device() is to use quirks, although it
might be hard to deal with PCI/ACPI ordering issues.

> +		struct acpi_device *adev;
> +		int constraint;
> +
> +		if (!pci_is_pcie(pci_dev) ||
> +		    !(pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ROOT_PORT))
> +			continue;
> +
> +		if (pci_dev->current_state == PCI_D3hot ||
> +		    pci_dev->current_state == PCI_D3cold)
> +			continue;

If we're trying to determine a property of the device, why does the
current power state make a difference?

It looks like this loop runs every time we suspend (from
amd_pmc_suspend_handler()), even though this is something we should
know at boot-time, so we only need it once.

> +		adev = ACPI_COMPANION(&pci_dev->dev);
> +		if (!adev)
> +			continue;
> +
> +		constraint = acpi_get_lps0_constraint(adev);
> +		if (constraint != ACPI_STATE_UNKNOWN &&
> +		    constraint >= ACPI_STATE_S3)
> +			continue;
> +
> +		if (pci_dev->bridge_d3 == 0)
> +			continue;
> +		pci_dev->bridge_d3 = 0;
> +		dev_info(&pci_dev->dev, "Disabling D3 on PCIe root port due lack of constraint\n");

D3hot?  D3cold?  Both?  "lack of constraint"?

> +	}
> +
> +	return 0;
> +}
> +
>  static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
>  {
>  	struct rtc_device *rtc_device;
> @@ -893,6 +928,10 @@ static int amd_pmc_suspend_handler(struct device *dev)
>  	case AMD_CPU_ID_CZN:
>  		rc = amd_pmc_czn_wa_irq1(pdev);
>  		break;
> +	case AMD_CPU_ID_YC:
> +	case AMD_CPU_ID_PS:
> +		rc = amd_pmc_rp_wa(pdev);
> +		break;
>  	default:
>  		break;
>  	}
> -- 
> 2.34.1
> 
