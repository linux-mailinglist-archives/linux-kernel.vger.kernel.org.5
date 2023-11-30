Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A95B7FFE76
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377157AbjK3W32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjK3W30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:29:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C0210F0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 14:29:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841CBC433C8;
        Thu, 30 Nov 2023 22:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701383372;
        bh=xXdpn8ztjDCF+QKM8kOKYVRvQMBg4yGAXaYhBN8ETGE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tG37005p5Tq4NYOwQu+Q8qEYoXuEet32U2BQfZ/pHNUhSzod5RfM4+595l3j4TXuH
         /A4eLuFMk9/yLaud/GUftCNzm6L3MxNrv9f9lpMRWRcO9aOhcPzkYwtND484ywORuF
         Oxmq56SWHodEhEO4VCeFrJ/AIlztnkzLP8sjyhuJVKDBGUp7HsRTGZhK2kDubCPHFI
         AQhm1jbwhdffi2gXdMJ8VKAQ3tjLlaeDEni5HSvWv9ECTNzRbvEhNAw6R1AP4M3nrr
         B8wyy2sOFZltNoNpWNkwrCoE/+CHxpMxwJUe09REwjLb4/J7l+081lD5OtqZrZ9iD5
         lW6JD6Jt1A1kw==
Date:   Thu, 30 Nov 2023 16:29:30 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: Call PCI ACPI _DSM with consistent revision
 argument
Message-ID: <20231130222930.GA488440@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110185503.46117-2-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 12:55:01PM -0600, Mario Limonciello wrote:
> The PCI ACPI _DSM is called across multiple places in the PCI core
> with different arguments for the revision.
> 
> The PCI firmware specification specifies that this is an incorrect
> behavior.
> "OSPM must invoke all Functions other than Function 0 with the
>  same Revision ID value"

This patch passes the same or a larger Revision ID than before, so
everything should work the same because the spec requires backwards
compatibility.  But it's conceivable that it could break on firmware
that does the revision check incorrectly.

Is this fixing a problem other than the spec compliance issue?

I agree the PCI FW spec says this.  It was added in r3.3 by the ECN at
https://members.pcisig.com/wg/Firmware/document/previewpdf/13988, but
I don't quite understand that ECN.

ACPI r6.5, sec 9.1.1, doesn't include the "must invoke all Functions
with same Revision ID" language, and the ASL example there clearly
treats revisions higher than those implemented by firmware as valid,
although new Functions added by those higher revisions are obviously
not supported.

PCI FW also says OSPM should not use a fixed Revision ID, but should
start with the highest known revision and "successively invoke
Function 0 with decremented values of Revision ID until system
firmware returns a value indicating support for more than Function 0"
(added by the same ECN), and I don't think Linux does this part.

So I think the fixed "pci_acpi_dsm_rev" value as in your patch works
fine with the ACPI ASL example, but it doesn't track the "successively
decrement" part of PCI FW.  I don't know the reason for that part of
the ECN.

Unrelated to this patch, I think it's a bug that Linux fails to invoke
Function 0 in a few cases, e.g., DSM_PCI_PRESERVE_BOOT_CONFIG,
DSM_PCI_POWER_ON_RESET_DELAY, and DSM_PCI_DEVICE_READINESS_DURATIONS.

Per spec, OSPM must invoke Function 0 to learn which other Functions
are supported.  It's not explicitly stated, but I think this is
required because a supported non-zero Function may return "any data
object", so there's no return value that would mean "this Function
Index is not supported." 

Bjorn

> Link: https://members.pcisig.com/wg/PCI-SIG/document/15350
>       PCI Firmware specification 3.3, section 4.6
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/pci_root.c  |  3 ++-
>  drivers/pci/pci-acpi.c   |  6 ++++--
>  drivers/pci/pci-label.c  |  4 ++--
>  drivers/pci/pcie/edr.c   | 13 +++++++------
>  include/linux/pci-acpi.h |  1 +
>  5 files changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 58b89b8d950e..bca2270a93d4 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -1055,7 +1055,8 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  	 * exists and returns 0, we must preserve any PCI resource
>  	 * assignments made by firmware for this host bridge.
>  	 */
> -	obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 1,
> +	obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge),
> +				      &pci_acpi_dsm_guid, pci_acpi_dsm_rev,
>  				      DSM_PCI_PRESERVE_BOOT_CONFIG, NULL, ACPI_TYPE_INTEGER);
>  	if (obj && obj->integer.value == 0)
>  		host_bridge->preserve_config = 1;
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 004575091596..bea72e807817 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -28,6 +28,7 @@
>  const guid_t pci_acpi_dsm_guid =
>  	GUID_INIT(0xe5c937d0, 0x3553, 0x4d7a,
>  		  0x91, 0x17, 0xea, 0x4d, 0x19, 0xc3, 0x43, 0x4d);
> +const int pci_acpi_dsm_rev = 5;
>
>  #if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_ARM64)
>  static int acpi_get_rc_addr(struct acpi_device *adev, struct resource *res)
> @@ -1215,7 +1216,8 @@ void acpi_pci_add_bus(struct pci_bus *bus)
>  	if (!pci_is_root_bus(bus))
>  		return;
>  
> -	obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 3,
> +	obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge),
> +				      &pci_acpi_dsm_guid, pci_acpi_dsm_rev,
>  				      DSM_PCI_POWER_ON_RESET_DELAY, NULL, ACPI_TYPE_INTEGER);
>  	if (!obj)
>  		return;
> @@ -1376,7 +1378,7 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
>  	if (bridge->ignore_reset_delay)
>  		pdev->d3cold_delay = 0;
>  
> -	obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 3,
> +	obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, pci_acpi_dsm_rev,
>  				      DSM_PCI_DEVICE_READINESS_DURATIONS, NULL,
>  				      ACPI_TYPE_PACKAGE);
>  	if (!obj)
> diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
> index 0c6446519640..91bdd04029f0 100644
> --- a/drivers/pci/pci-label.c
> +++ b/drivers/pci/pci-label.c
> @@ -41,7 +41,7 @@ static bool device_has_acpi_name(struct device *dev)
>  	if (!handle)
>  		return false;
>  
> -	return acpi_check_dsm(handle, &pci_acpi_dsm_guid, 0x2,
> +	return acpi_check_dsm(handle, &pci_acpi_dsm_guid, pci_acpi_dsm_rev,
>  			      1 << DSM_PCI_DEVICE_NAME);
>  #else
>  	return false;
> @@ -162,7 +162,7 @@ static int dsm_get_label(struct device *dev, char *buf,
>  	if (!handle)
>  		return -1;
>  
> -	obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 0x2,
> +	obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, pci_acpi_dsm_rev,
>  				DSM_PCI_DEVICE_NAME, NULL);
>  	if (!obj)
>  		return -1;
> diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
> index 5f4914d313a1..ab6a50201124 100644
> --- a/drivers/pci/pcie/edr.c
> +++ b/drivers/pci/pcie/edr.c
> @@ -35,7 +35,7 @@ static int acpi_enable_dpc(struct pci_dev *pdev)
>  	 * Behavior when calling unsupported _DSM functions is undefined,
>  	 * so check whether EDR_PORT_DPC_ENABLE_DSM is supported.
>  	 */
> -	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
> +	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, pci_acpi_dsm_rev,
>  			    1ULL << EDR_PORT_DPC_ENABLE_DSM))
>  		return 0;
>  
> @@ -51,8 +51,9 @@ static int acpi_enable_dpc(struct pci_dev *pdev)
>  	 * Firmware Specification r3.2, sec 4.6.12, EDR_PORT_DPC_ENABLE_DSM is
>  	 * optional.  Return success if it's not implemented.
>  	 */
> -	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
> -				EDR_PORT_DPC_ENABLE_DSM, &argv4);
> +	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid,
> +				pci_acpi_dsm_rev, EDR_PORT_DPC_ENABLE_DSM,
> +				&argv4);
>  	if (!obj)
>  		return 0;
>  
> @@ -88,12 +89,12 @@ static struct pci_dev *acpi_dpc_port_get(struct pci_dev *pdev)
>  	 * Behavior when calling unsupported _DSM functions is undefined,
>  	 * so check whether EDR_PORT_DPC_ENABLE_DSM is supported.
>  	 */
> -	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
> +	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, pci_acpi_dsm_rev,
>  			    1ULL << EDR_PORT_LOCATE_DSM))
>  		return pci_dev_get(pdev);
>  
> -	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
> -				EDR_PORT_LOCATE_DSM, NULL);
> +	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid,
> +				pci_acpi_dsm_rev, EDR_PORT_LOCATE_DSM, NULL);
>  	if (!obj)
>  		return pci_dev_get(pdev);
>  
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index 078225b514d4..7966ef8f14b3 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -115,6 +115,7 @@ static inline void acpiphp_check_host_bridge(struct acpi_device *adev) { }
>  #endif
>  
>  extern const guid_t pci_acpi_dsm_guid;
> +extern const int pci_acpi_dsm_rev;
>  
>  /* _DSM Definitions for PCI */
>  #define DSM_PCI_PRESERVE_BOOT_CONFIG		0x05
> -- 
> 2.34.1
> 
