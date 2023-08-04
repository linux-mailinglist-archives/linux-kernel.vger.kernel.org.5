Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9C776FCBB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjHDJAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjHDJAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:00:25 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFAC6581;
        Fri,  4 Aug 2023 01:54:59 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qRqaA-0005M1-Tj; Fri, 04 Aug 2023 10:54:50 +0200
Message-ID: <f11ba0ef-0bb1-b925-3088-2ba7a8d17393@leemhuis.info>
Date:   Fri, 4 Aug 2023 10:54:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btrtl: Load FW v2 otherwise FW v1 for RTL8852C
Content-Language: en-US, de-DE
To:     max.chou@realtek.com, marcel@holtmann.org
Cc:     johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex_lu@realsil.com.cn, hildawu@realtek.com, karenhsu@realtek.com,
        kidman@realtek.com, juerg.haefliger@canonical.com,
        vicamo.yang@canonical.com, Riley.Kao@dell.com,
        Josh Boyer <jwboyer@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230804055426.6806-1-max.chou@realtek.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230804055426.6806-1-max.chou@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1691139299;a9357e4e;
X-HE-SMSGID: 1qRqaA-0005M1-Tj
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing the linux-firmware maintainer, the network maintainers, and the
regressions lists]

On 04.08.23 07:54, max.chou@realtek.com wrote:
> From: Max Chou <max.chou@realtek.com>
> 
> In the commit of linux-firmware project, rtl8852cu_fw.bin is updated as
> FW v2 format[1]. Consider the case that if driver did not be updated fo> FW v2 supported[2], it can not use FW v2.
>
> By Canonical's suggestion, older driver should be able to load FW v1,

Well, that's not only Canonical suggestion, that is how things are
supposed to be handled in general. See
Documentation/driver-api/firmware/firmware-usage-guidelines.rst (alt:
https://docs.kernel.org/driver-api/firmware/firmware-usage-guidelines.html
) for details.

We had a similar situation in March already with a Wifi driver:
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/?id=416a66cae796939d7d096988c72c641656c81c5a

Makes me wonder: is there a problem here we should try harder to avoid?
Especially as the problem in this case would have been simple to predict
by reading the changelog of the linux-firmware change. To quote from
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/?id=55e7448533e7

```
Note: This firmware patch needs to be used with driver
"btrtl: Firmware format v2 support". Please update the
driver with this commit: 9a24ce5e29b15c4c6b0c89c04f9df6ce14addefa
```

> so rtl8852cu_fw.bin will be revert to the previous commit as FW v1 and
> add rtl8852cu_fw_v2.bin as FW v2. This item will be started on
> linux-firmware project.
> 
> In this commit, the driver prefers to load FW v2 if available. Fallback to
> FW v1 otherwise.
> 
> To do on linux-firmware project.
> rtl_bt/rtl8852cu_fw.bin: FW v1 (stay at ver. 0xD7B8_FABF)
> rtl_bt/rtl8852cu_fw_v2.bin: FW v2 (to be maintained)
> 
> [1]'9a24ce5e29b1 ("Bluetooth: btrtl: Firmware format v2 support")'
> [2]'55e7448533e7 ("rtl_bt: Update RTL8852C BT USB firmware
>     to 0x040D_7225")'

You seem to have mixed up [1] and [2] here, or did my brain go sideways
somewhere?

> Suggested-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> Tested-by: Hilda Wu <hildawu@realtek.com>

All that sounds like this should also have these tags to to ensure this
makes it back too all trees that applied 9a24ce5e29b:

 Fixes: 9a24ce5e29b ("Bluetooth: btrtl: Firmware format v2 support")
 Cc: stable@vger.kernel.org

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

> Signed-off-by: Max Chou <max.chou@realtek.com>
> ---
>  drivers/bluetooth/btrtl.c | 68 +++++++++++++++++++++++++--------------
>  1 file changed, 44 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index ddae6524106d..8bfa86dd12f7 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -104,7 +104,7 @@ static const struct id_table ic_id_table[] = {
>  	{ IC_INFO(RTL_ROM_LMP_8723A, 0xb, 0x6, HCI_USB),
>  	  .config_needed = false,
>  	  .has_rom_version = false,
> -	  .fw_name = "rtl_bt/rtl8723a_fw.bin",
> +	  .fw_name = "rtl_bt/rtl8723a_fw",
>  	  .cfg_name = NULL,
>  	  .hw_info = "rtl8723au" },
>  
> @@ -112,7 +112,7 @@ static const struct id_table ic_id_table[] = {
>  	{ IC_INFO(RTL_ROM_LMP_8723B, 0xb, 0x6, HCI_UART),
>  	  .config_needed = true,
>  	  .has_rom_version = true,
> -	  .fw_name  = "rtl_bt/rtl8723bs_fw.bin",
> +	  .fw_name  = "rtl_bt/rtl8723bs_fw",
>  	  .cfg_name = "rtl_bt/rtl8723bs_config",
>  	  .hw_info  = "rtl8723bs" },
>  
> @@ -120,7 +120,7 @@ static const struct id_table ic_id_table[] = {
>  	{ IC_INFO(RTL_ROM_LMP_8723B, 0xb, 0x6, HCI_USB),
>  	  .config_needed = false,
>  	  .has_rom_version = true,
> -	  .fw_name  = "rtl_bt/rtl8723b_fw.bin",
> +	  .fw_name  = "rtl_bt/rtl8723b_fw",
>  	  .cfg_name = "rtl_bt/rtl8723b_config",
>  	  .hw_info  = "rtl8723bu" },
>  
> @@ -132,7 +132,7 @@ static const struct id_table ic_id_table[] = {
>  	  .hci_bus = HCI_UART,
>  	  .config_needed = true,
>  	  .has_rom_version = true,
> -	  .fw_name  = "rtl_bt/rtl8723cs_cg_fw.bin",
> +	  .fw_name  = "rtl_bt/rtl8723cs_cg_fw",
>  	  .cfg_name = "rtl_bt/rtl8723cs_cg_config",
>  	  .hw_info  = "rtl8723cs-cg" },
>  
> @@ -144,7 +144,7 @@ static const struct id_table ic_id_table[] = {
>  	  .hci_bus = HCI_UART,
>  	  .config_needed = true,
>  	  .has_rom_version = true,
> -	  .fw_name  = "rtl_bt/rtl8723cs_vf_fw.bin",
> +	  .fw_name  = "rtl_bt/rtl8723cs_vf_fw",
>  	  .cfg_name = "rtl_bt/rtl8723cs_vf_config",
>  	  .hw_info  = "rtl8723cs-vf" },
>  
> @@ -156,7 +156,7 @@ static const struct id_table ic_id_table[] = {
>  	  .hci_bus = HCI_UART,
>  	  .config_needed = true,
>  	  .has_rom_version = true,
> -	  .fw_name  = "rtl_bt/rtl8723cs_xx_fw.bin",
> +	  .fw_name  = "rtl_bt/rtl8723cs_xx_fw",
>  	  .cfg_name = "rtl_bt/rtl8723cs_xx_config",
>  	  .hw_info  = "rtl8723cs" },
>  
> @@ -164,7 +164,7 @@ static const struct id_table ic_id_table[] = {
>  	{ IC_INFO(RTL_ROM_LMP_8723B, 0xd, 0x8, HCI_USB),
>  	  .config_needed = true,
>  	  .has_rom_version = true,
> -	  .fw_name  = "rtl_bt/rtl8723d_fw.bin",
> +	  .fw_name  = "rtl_bt/rtl8723d_fw",
>  	  .cfg_name = "rtl_bt/rtl8723d_config",
>  	  .hw_info  = "rtl8723du" },
>  
> @@ -172,7 +172,7 @@ static const struct id_table ic_id_table[] = {
>  	{ IC_INFO(RTL_ROM_LMP_8723B, 0xd, 0x8, HCI_UART),
>  	  .config_needed = true,
>  	  .has_rom_version = true,
> -	  .fw_name  = "rtl_bt/rtl8723ds_fw.bin",
> +	  .fw_name  = "rtl_bt/rtl8723ds_fw",
>  	  .cfg_name = "rtl_bt/rtl8723ds_config",
>  	  .hw_info  = "rtl8723ds" },
>  
> @@ -180,7 +180,7 @@ static const struct id_table ic_id_table[] = {
>  	{ IC_INFO(RTL_ROM_LMP_8821A, 0xa, 0x6, HCI_USB),
>  	  .config_needed = false,
>  	  .has_rom_version = true,
> -	  .fw_name  = "rtl_bt/rtl8821a_fw.bin",
> +	  .fw_name  = "rtl_bt/rtl8821a_fw",
>  	  .cfg_name = "rtl_bt/rtl8821a_config",
>  	  .hw_info  = "rtl8821au" },
>  
> @@ -189,7 +189,7 @@ static const struct id_table ic_id_table[] = {
>  	  .config_needed = false,
>  	  .has_rom_version = true,
>  	  .has_msft_ext = true,
> -	  .fw_name  = "rtl_bt/rtl8821c_fw.bin",
> +	  .fw_name  = "rtl_bt/rtl8821c_fw",
>  	  .cfg_name = "rtl_bt/rtl8821c_config",
>  	  .hw_info  = "rtl8821cu" },
>  
> @@ -198,7 +198,7 @@ static const struct id_table ic_id_table[] = {
>  	  .config_needed = true,
>  	  .has_rom_version = true,
>  	  .has_msft_ext = true,
> -	  .fw_name  = "rtl_bt/rtl8821cs_fw.bin",
> +	  .fw_name  = "rtl_bt/rtl8821cs_fw",
>  	  .cfg_name = "rtl_bt/rtl8821cs_config",
>  	  .hw_info  = "rtl8821cs" },
>  
> @@ -206,7 +206,7 @@ static const struct id_table ic_id_table[] = {
>  	{ IC_INFO(RTL_ROM_LMP_8761A, 0xa, 0x6, HCI_USB),
>  	  .config_needed = false,
>  	  .has_rom_version = true,
> -	  .fw_name  = "rtl_bt/rtl8761a_fw.bin",
> +	  .fw_name  = "rtl_bt/rtl8761a_fw",
>  	  .cfg_name = "rtl_bt/rtl8761a_config",
>  	  .hw_info  = "rtl8761au" },
>  
> @@ -215,7 +215,7 @@ static const struct id_table ic_id_table[] = {
>  	  .config_needed = false,
>  	  .has_rom_version = true,
>  	  .has_msft_ext = true,
> -	  .fw_name  = "rtl_bt/rtl8761b_fw.bin",
> +	  .fw_name  = "rtl_bt/rtl8761b_fw",
>  	  .cfg_name = "rtl_bt/rtl8761b_config",
>  	  .hw_info  = "rtl8761btv" },
>  
> @@ -223,7 +223,7 @@ static const struct id_table ic_id_table[] = {
>  	{ IC_INFO(RTL_ROM_LMP_8761A, 0xb, 0xa, HCI_USB),
>  	  .config_needed = false,
>  	  .has_rom_version = true,
> -	  .fw_name  = "rtl_bt/rtl8761bu_fw.bin",
> +	  .fw_name  = "rtl_bt/rtl8761bu_fw",
>  	  .cfg_name = "rtl_bt/rtl8761bu_config",
>  	  .hw_info  = "rtl8761bu" },
>  
> @@ -232,7 +232,7 @@ static const struct id_table ic_id_table[] = {
>  	  .config_needed = true,
>  	  .has_rom_version = true,
>  	  .has_msft_ext = true,
> -	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
> +	  .fw_name  = "rtl_bt/rtl8822cs_fw",
>  	  .cfg_name = "rtl_bt/rtl8822cs_config",
>  	  .hw_info  = "rtl8822cs" },
>  
> @@ -241,7 +241,7 @@ static const struct id_table ic_id_table[] = {
>  	  .config_needed = true,
>  	  .has_rom_version = true,
>  	  .has_msft_ext = true,
> -	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
> +	  .fw_name  = "rtl_bt/rtl8822cs_fw",
>  	  .cfg_name = "rtl_bt/rtl8822cs_config",
>  	  .hw_info  = "rtl8822cs" },
>  
> @@ -250,7 +250,7 @@ static const struct id_table ic_id_table[] = {
>  	  .config_needed = false,
>  	  .has_rom_version = true,
>  	  .has_msft_ext = true,
> -	  .fw_name  = "rtl_bt/rtl8822cu_fw.bin",
> +	  .fw_name  = "rtl_bt/rtl8822cu_fw",
>  	  .cfg_name = "rtl_bt/rtl8822cu_config",
>  	  .hw_info  = "rtl8822cu" },
>  
> @@ -259,7 +259,7 @@ static const struct id_table ic_id_table[] = {
>  	  .config_needed = true,
>  	  .has_rom_version = true,
>  	  .has_msft_ext = true,
> -	  .fw_name  = "rtl_bt/rtl8822b_fw.bin",
> +	  .fw_name  = "rtl_bt/rtl8822b_fw",
>  	  .cfg_name = "rtl_bt/rtl8822b_config",
>  	  .hw_info  = "rtl8822bu" },
>  
> @@ -268,7 +268,7 @@ static const struct id_table ic_id_table[] = {
>  	  .config_needed = false,
>  	  .has_rom_version = true,
>  	  .has_msft_ext = true,
> -	  .fw_name  = "rtl_bt/rtl8852au_fw.bin",
> +	  .fw_name  = "rtl_bt/rtl8852au_fw",
>  	  .cfg_name = "rtl_bt/rtl8852au_config",
>  	  .hw_info  = "rtl8852au" },
>  
> @@ -277,7 +277,7 @@ static const struct id_table ic_id_table[] = {
>  	  .config_needed = true,
>  	  .has_rom_version = true,
>  	  .has_msft_ext = true,
> -	  .fw_name  = "rtl_bt/rtl8852bs_fw.bin",
> +	  .fw_name  = "rtl_bt/rtl8852bs_fw",
>  	  .cfg_name = "rtl_bt/rtl8852bs_config",
>  	  .hw_info  = "rtl8852bs" },
>  
> @@ -286,7 +286,7 @@ static const struct id_table ic_id_table[] = {
>  	  .config_needed = false,
>  	  .has_rom_version = true,
>  	  .has_msft_ext = true,
> -	  .fw_name  = "rtl_bt/rtl8852bu_fw.bin",
> +	  .fw_name  = "rtl_bt/rtl8852bu_fw",
>  	  .cfg_name = "rtl_bt/rtl8852bu_config",
>  	  .hw_info  = "rtl8852bu" },
>  
> @@ -295,7 +295,7 @@ static const struct id_table ic_id_table[] = {
>  	  .config_needed = false,
>  	  .has_rom_version = true,
>  	  .has_msft_ext = true,
> -	  .fw_name  = "rtl_bt/rtl8852cu_fw.bin",
> +	  .fw_name  = "rtl_bt/rtl8852cu_fw",
>  	  .cfg_name = "rtl_bt/rtl8852cu_config",
>  	  .hw_info  = "rtl8852cu" },
>  
> @@ -304,7 +304,7 @@ static const struct id_table ic_id_table[] = {
>  	  .config_needed = false,
>  	  .has_rom_version = true,
>  	  .has_msft_ext = false,
> -	  .fw_name  = "rtl_bt/rtl8851bu_fw.bin",
> +	  .fw_name  = "rtl_bt/rtl8851bu_fw",
>  	  .cfg_name = "rtl_bt/rtl8851bu_config",
>  	  .hw_info  = "rtl8851bu" },
>  	};
> @@ -1045,10 +1045,12 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
>  	struct sk_buff *skb;
>  	struct hci_rp_read_local_version *resp;
>  	struct hci_command_hdr *cmd;
> +	char fw_name[40];
>  	char cfg_name[40];
>  	u16 hci_rev, lmp_subver;
>  	u8 hci_ver, lmp_ver, chip_type = 0;
>  	int ret;
> +	int fw_load_retry = 0;
>  	u8 reg_val[2];
>  
>  	btrtl_dev = kzalloc(sizeof(*btrtl_dev), GFP_KERNEL);
> @@ -1154,9 +1156,26 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
>  			goto err_free;
>  	}
>  
> -	btrtl_dev->fw_len = rtl_load_file(hdev, btrtl_dev->ic_info->fw_name,
> +fw_name_load:
> +	if (btrtl_dev->ic_info->fw_name) {
> +		if (lmp_subver == RTL_ROM_LMP_8852A && hci_rev == 0x000c &&
> +				  fw_load_retry == 0) {
> +			fw_load_retry = 1;
> +			snprintf(fw_name, sizeof(fw_name), "%s_v2.bin",
> +				 btrtl_dev->ic_info->fw_name);
> +		} else {
> +			fw_load_retry = 0;
> +			snprintf(fw_name, sizeof(fw_name), "%s.bin",
> +				 btrtl_dev->ic_info->fw_name);
> +		}
> +		btrtl_dev->fw_len = rtl_load_file(hdev, fw_name,
>  					  &btrtl_dev->fw_data);
> +	}
> +
>  	if (btrtl_dev->fw_len < 0) {
> +		if (fw_load_retry == 1)
> +			goto fw_name_load;
> +
>  		rtl_dev_err(hdev, "firmware file %s not found",
>  			    btrtl_dev->ic_info->fw_name);
>  		ret = btrtl_dev->fw_len;
> @@ -1491,4 +1510,5 @@ MODULE_FIRMWARE("rtl_bt/rtl8852bs_config.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8852bu_fw.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8852bu_config.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw_v2.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8852cu_config.bin");
