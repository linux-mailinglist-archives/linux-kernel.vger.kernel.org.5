Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234347539B8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 13:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbjGNLk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 07:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbjGNLkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:40:49 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425D535AE;
        Fri, 14 Jul 2023 04:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689334808; x=1689939608; i=linosanfilippo@gmx.de;
 bh=lBOJf7LnGf42QJ4pEtT5JT3sukA9e1BFjJxw8/BOquM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=mHLoTZbRsoCXVpZW+PrALu7ztPcZlg2bxLxdiJWn3tEkgz6bNjhoVPbmnK1X07a1f8dReR8
 PYBSB0775gIQpXCST2ZvYkJMttWAbPLAX1eHfG4koKRh1SvquitrIS/JRTajC9iReTuHdvLbr
 bdsYht10n9wEpA58yTg3apj4CzQrDFThD2g46GDN63E00lWoOE3FiBRDSzvVe1JLhFLHlJo4I
 /q6syvW6U2MlNztK8uoqnqcDhgGkUyDOyzB9pXOAibKLQV5CbjRQiSJEcbsJYfgYetzQ96qX0
 wAw3+2MLaq6Cg3kVLtudedpFiOwlFx3Zq3WZ4RnJiUNJaB0vb5Pg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.10.87] ([180.183.243.38]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1po0-1qMU511URE-002IpQ; Fri, 14
 Jul 2023 13:40:08 +0200
Message-ID: <5be1b7b6-7f7b-a201-0152-a5b50c48073e@gmx.de>
Date:   Fri, 14 Jul 2023 13:40:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 RESEND] tpm,tpm_tis: Disable interrupts after 1000
 unhandled IRQs
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     jsnitsel@redhat.com, hdegoede@redhat.com, oe-lkp@lists.linux.dev,
        lkp@intel.com,
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        peterz@infradead.org,
        =?UTF-8?Q?Michael_Niew=c3=b6hner?= <linux@mniewoehner.de>,
        Linux Kernel Integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Philipp Rosenberger <p.rosenberger@kunbus.com>
References: <144f1c66-499e-2da9-c4c1-b5f26cb8841f@kunbus.com>
 <CU1KZQOWE7P0.2DDYENDH5U99M@seitikki>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <CU1KZQOWE7P0.2DDYENDH5U99M@seitikki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v5bUbCfpF7r5GASdljh/kPB33WFAChmpLoyKYACBLd9Pe2zxTAS
 MJgOQ02VCuXFw3+hVktAnwINDipdcjv9JGZ5MQU1Pe/AIHzEGxoqW/JY00VtjYfova0uD0Q
 4diDNdfvcTbOik2linDLOlpD+SgQihfcKEXYO7h4Kxhiwj03JShfz1VGDS4CX/vFEbCMouv
 J5BlQSn7319X/iWGc/+UA==
UI-OutboundReport: junk:10;M01:P0:NYxcuu4CS1g=;yUCgLiwZNR38r32zIic6vFDHOJ/ps
 DUdnv8tO7ZSpsy9T7dKtIVT3ApZpIbe12yncgMyzkuQdme1JQcIaxTLEOpyh82PSczDQiI6XJ
 G7uM/uaNJJqvGhhALopu0JdtfbKPF5yCr+l0fTktw8+6fVNPxwDxHjX8Of8v+ojDK5n8XXZxW
 UU19G7/QQsyO8eYNH8T1KYF2cqdc2vuzQvHCGtAt0VDIZLbUo/btxf/mD1WewmERDlOLkGx/F
 KEgAyEuDVJuy0xpy36amKOptlxMO9yx5dg3mQaxNHTkkSJSOR5azYMbjVrDlF95XqD8m8K0+7
 9UbiM6WFp7ptn6Fut8vYqZEVp7XoUBKWVX9onoGoOqnsSljoY5Ypy5xuqSpqus3z+uRGPPfi7
 Ut52i32fuWA9O+ZiFWCnoK/FGDrbGMF31+Ibym13sCwBS7i/RQ2Nf7jFdIA2fPVGX8GcuPSZk
 9yrGunT6DgU3GigNk922aFqSPsREwgTWE0Z0hXnUKdDklC35qnOt8Jgik8oFSD28zJ0yALfEP
 w/YkmCPSS4D9QH7pgq42djOJsbHtkA90mWmwf9xvoYq0ex/oA/QXg6Vn4fi6t908reWtbN/af
 TO2X9nrYDxvZ4dlB+4L/dOejRZ8wcZWT527uWkUkYY0DpzAyK3TQPczF78bVgrGf5aYEfsIoT
 oHMmq9F9f0aqKw5BSXeujpjmJ6b1XBQyu5dkv2/n7owrR6L4OdlAmiqqFyHTnfTjtupmoasdU
 R1yJKKxNeWt+tK225vliIQZJoeoLVM8v1mSZ4yWYRLOlmZ7LBJGv/3IvJLmU2ckYLA+Uz6Dif
 xZjwrmBsacpgu1IRqDamNwQ7bsQX+5RHj7tLrLWNGUdD9DoWZewm2JF97F/lY9ssDQvjbxrO3
 f1VLAyPpOkpoT88RxrL9q8pgx9NHjfoB6crueEqhnSF01CyylWIr489i76wcLtZ50kCYD+dd2
 BrXLWEq8kTX/lNyjaviEVVBtWmG5KbyFLSGWs6gVuBSS/T
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.07.23 05:39, Jarkko Sakkinen wrote:
> On Thu Jul 13, 2023 at 7:01 PM UTC, Lino Sanfilippo wrote:
>> After activation of interrupts for TPM TIS drivers 0-day reports an
>> interrupt storm on an Inspur NF5180M6 server.
>>
>> Fix this by detecting the storm and falling back to polling:
>> Count the number of unhandled interrupts within a 10 ms time interval. =
In
>> case that more than 1000 were unhandled deactivate interrupts entirely,
>> deregister the handler and use polling instead.
>>
>> Also print a note to point to the tpm_tis_dmi_table.
>>
>> Since the interrupt deregistration function devm_free_irq() waits for a=
ll
>> interrupt handlers to finish, only trigger a worker in the interrupt
>> handler and do the unregistration in the worker to avoid a deadlock.
>>
>> Note: the storm detection logic equals the implementation in
>> note_interrupt() which uses timestamps and counters stored in struct
>> irq_desc. Since this structure is private to the generic interrupt core
>> the TPM TIS core uses its own timestamps and counters. Furthermore the =
TPM
>> interrupt handler always returns IRQ_HANDLED to prevent the generic
>> interrupt core from processing the interrupt storm.
>>
>> Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
>> Reported-by: kernel test robot <yujie.liu@intel.com>
>> Closes: https://lore.kernel.org/oe-lkp/202305041325.ae8b0c43-yujie.liu@=
intel.com/
>> Suggested-by: Lukas Wunner <lukas@wunner.de>
>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>> ---
>>  drivers/char/tpm/tpm_tis_core.c | 103 +++++++++++++++++++++++++++-----
>>  drivers/char/tpm/tpm_tis_core.h |   4 ++
>>  2 files changed, 92 insertions(+), 15 deletions(-)
>>
>> Resending the patch due to several bounce messages for the first attemp=
t.
>>
>> Changes to v3 (all requested by Jarko):
>> - remove all inline comments
>> - rename tpm_tis_reenable_polling() to tpm_tis_revert_interrupts()
>> - rename tpm_tis_check_for_interrupt_storm() to tpm_tis_update_unhandle=
d_irqs()
>> - rename label "unhandled" to "err"
>> - add Fixes: tag
>>
>> Changes to v2:
>> - use define for max number of unhandles irqs(requested by Jarko)
>> - rename intmask to int_mask (requested by Jarko)
>> - rephrased short summary (requested by Jarko)
>> - rename disable_interrupts to tpm_tis_disable_interrupts (requested by=
 Jarko)
>> - print info message concerning adding an entry to tpm_tis_dmi_table
>>   (suggested by Jerry)
>> - amended commit message
>> - handle failure of locality request by returning IRQ_NONE
>> - dont take and release locality in __tpm_tis_disable_interrupts but in=
 its
>> caller
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis=
_core.c
>> index 558144fa707a..88a5384c09c0 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -24,9 +24,12 @@
>>  #include <linux/wait.h>
>>  #include <linux/acpi.h>
>>  #include <linux/freezer.h>
>> +#include <linux/dmi.h>
>>  #include "tpm.h"
>>  #include "tpm_tis_core.h"
>>
>> +#define TPM_TIS_MAX_UNHANDLED_IRQS	1000
>> +
>>  static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value);
>>
>>  static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
>> @@ -468,25 +471,29 @@ static int tpm_tis_send_data(struct tpm_chip *chi=
p, const u8 *buf, size_t len)
>>  	return rc;
>>  }
>>
>> -static void disable_interrupts(struct tpm_chip *chip)
>> +static void __tpm_tis_disable_interrupts(struct tpm_chip *chip)
>> +{
>> +	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
>> +	u32 int_mask =3D 0;
>> +
>> +	tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &int_mask);
>> +	int_mask &=3D ~TPM_GLOBAL_INT_ENABLE;
>> +	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), int_mask);
>> +
>> +	chip->flags &=3D ~TPM_CHIP_FLAG_IRQ;
>> +}
>> +
>> +static void tpm_tis_disable_interrupts(struct tpm_chip *chip)
>>  {
>>  	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
>> -	u32 intmask;
>> -	int rc;
>>
>>  	if (priv->irq =3D=3D 0)
>>  		return;
>>
>> -	rc =3D tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask)=
;
>> -	if (rc < 0)
>> -		intmask =3D 0;
>> -
>> -	intmask &=3D ~TPM_GLOBAL_INT_ENABLE;
>> -	rc =3D tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask)=
;
>> +	__tpm_tis_disable_interrupts(chip);
>>
>>  	devm_free_irq(chip->dev.parent, priv->irq, chip);
>>  	priv->irq =3D 0;
>> -	chip->flags &=3D ~TPM_CHIP_FLAG_IRQ;
>>  }
>>
>>  /*
>> @@ -552,7 +559,7 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *=
buf, size_t len)
>>  	if (!test_bit(TPM_TIS_IRQ_TESTED, &priv->flags))
>>  		tpm_msleep(1);
>>  	if (!test_bit(TPM_TIS_IRQ_TESTED, &priv->flags))
>> -		disable_interrupts(chip);
>> +		tpm_tis_disable_interrupts(chip);
>>  	set_bit(TPM_TIS_IRQ_TESTED, &priv->flags);
>>  	return rc;
>>  }
>> @@ -752,6 +759,57 @@ static bool tpm_tis_req_canceled(struct tpm_chip *=
chip, u8 status)
>>  	return status =3D=3D TPM_STS_COMMAND_READY;
>>  }
>>
>> +static irqreturn_t tpm_tis_revert_interrupts(struct tpm_chip *chip)
>> +{
>> +	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
>> +	const char *product;
>> +	const char *vendor;
>> +
>> +	dev_warn(&chip->dev, FW_BUG
>> +		 "TPM interrupt storm detected, polling instead\n");
>> +
>> +	vendor =3D dmi_get_system_info(DMI_SYS_VENDOR);
>> +	product =3D dmi_get_system_info(DMI_PRODUCT_VERSION);
>> +
>> +	if (vendor && product) {
>> +		dev_info(&chip->dev,
>> +			"Consider adding the following entry to tpm_tis_dmi_table:\n");
>> +		dev_info(&chip->dev, "\tDMI_SYS_VENDOR: %s\n", vendor);
>> +		dev_info(&chip->dev, "\tDMI_PRODUCT_VERSION: %s\n", product);
>> +	}
>> +
>> +	if (tpm_tis_request_locality(chip, 0) !=3D 0)
>> +		return IRQ_NONE;
>> +
>> +	__tpm_tis_disable_interrupts(chip);
>> +	tpm_tis_relinquish_locality(chip, 0);
>> +
>> +	schedule_work(&priv->free_irq_work);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static irqreturn_t tpm_tis_update_unhandled_irqs(struct tpm_chip *chip=
)
>> +{
>> +	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
>> +	irqreturn_t irqret =3D IRQ_HANDLED;
>> +
>> +	if (!(chip->flags & TPM_CHIP_FLAG_IRQ))
>> +		return IRQ_HANDLED;
>> +
>> +	if (time_after(jiffies, priv->last_unhandled_irq + HZ/10))
>> +		priv->unhandled_irqs =3D 1;
>> +	else
>> +		priv->unhandled_irqs++;
>> +
>> +	priv->last_unhandled_irq =3D jiffies;
>> +
>> +	if (priv->unhandled_irqs > TPM_TIS_MAX_UNHANDLED_IRQS)
>> +		irqret =3D tpm_tis_revert_interrupts(chip);
>> +
>> +	return irqret;
>> +}
>> +
>>  static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>>  {
>>  	struct tpm_chip *chip =3D dev_id;
>> @@ -761,10 +819,10 @@ static irqreturn_t tis_int_handler(int dummy, voi=
d *dev_id)
>>
>>  	rc =3D tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrup=
t);
>>  	if (rc < 0)
>> -		return IRQ_NONE;
>> +		goto err;
>>
>>  	if (interrupt =3D=3D 0)
>> -		return IRQ_NONE;
>> +		goto err;
>>
>>  	set_bit(TPM_TIS_IRQ_TESTED, &priv->flags);
>>  	if (interrupt & TPM_INTF_DATA_AVAIL_INT)
>> @@ -780,10 +838,13 @@ static irqreturn_t tis_int_handler(int dummy, voi=
d *dev_id)
>>  	rc =3D tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), interrup=
t);
>>  	tpm_tis_relinquish_locality(chip, 0);
>>  	if (rc < 0)
>> -		return IRQ_NONE;
>> +		goto err;
>>
>>  	tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrupt);
>>  	return IRQ_HANDLED;
>> +
>> +err:
>> +	return tpm_tis_update_unhandled_irqs(chip);
>>  }
>>
>>  static void tpm_tis_gen_interrupt(struct tpm_chip *chip)
>> @@ -804,6 +865,15 @@ static void tpm_tis_gen_interrupt(struct tpm_chip =
*chip)
>>  		chip->flags &=3D ~TPM_CHIP_FLAG_IRQ;
>>  }
>>
>> +static void tpm_tis_free_irq_func(struct work_struct *work)
>> +{
>> +	struct tpm_tis_data *priv =3D container_of(work, typeof(*priv), free_=
irq_work);
>> +	struct tpm_chip *chip =3D priv->chip;
>> +
>> +	devm_free_irq(chip->dev.parent, priv->irq, chip);
>> +	priv->irq =3D 0;
>> +}
>> +
>>  /* Register the IRQ and issue a command that will cause an interrupt. =
If an
>>   * irq is seen then leave the chip setup for IRQ operation, otherwise =
reverse
>>   * everything and leave in polling mode. Returns 0 on success.
>> @@ -816,6 +886,7 @@ static int tpm_tis_probe_irq_single(struct tpm_chip=
 *chip, u32 intmask,
>>  	int rc;
>>  	u32 int_status;
>>
>> +	INIT_WORK(&priv->free_irq_work, tpm_tis_free_irq_func);
>>
>>  	rc =3D devm_request_threaded_irq(chip->dev.parent, irq, NULL,
>>  				       tis_int_handler, IRQF_ONESHOT | flags,
>> @@ -918,6 +989,7 @@ void tpm_tis_remove(struct tpm_chip *chip)
>>  		interrupt =3D 0;
>>
>>  	tpm_tis_write32(priv, reg, ~TPM_GLOBAL_INT_ENABLE & interrupt);
>> +	flush_work(&priv->free_irq_work);
>>
>>  	tpm_tis_clkrun_enable(chip, false);
>>
>> @@ -1021,6 +1093,7 @@ int tpm_tis_core_init(struct device *dev, struct =
tpm_tis_data *priv, int irq,
>>  	chip->timeout_b =3D msecs_to_jiffies(TIS_TIMEOUT_B_MAX);
>>  	chip->timeout_c =3D msecs_to_jiffies(TIS_TIMEOUT_C_MAX);
>>  	chip->timeout_d =3D msecs_to_jiffies(TIS_TIMEOUT_D_MAX);
>> +	priv->chip =3D chip;
>>  	priv->timeout_min =3D TPM_TIMEOUT_USECS_MIN;
>>  	priv->timeout_max =3D TPM_TIMEOUT_USECS_MAX;
>>  	priv->phy_ops =3D phy_ops;
>> @@ -1179,7 +1252,7 @@ int tpm_tis_core_init(struct device *dev, struct =
tpm_tis_data *priv, int irq,
>>  			rc =3D tpm_tis_request_locality(chip, 0);
>>  			if (rc < 0)
>>  				goto out_err;
>> -			disable_interrupts(chip);
>> +			tpm_tis_disable_interrupts(chip);
>>  			tpm_tis_relinquish_locality(chip, 0);
>>  		}
>>  	}
>> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis=
_core.h
>> index 610bfadb6acf..b1a169d7d1ca 100644
>> --- a/drivers/char/tpm/tpm_tis_core.h
>> +++ b/drivers/char/tpm/tpm_tis_core.h
>> @@ -91,11 +91,15 @@ enum tpm_tis_flags {
>>  };
>>
>>  struct tpm_tis_data {
>> +	struct tpm_chip *chip;
>>  	u16 manufacturer_id;
>>  	struct mutex locality_count_mutex;
>>  	unsigned int locality_count;
>>  	int locality;
>>  	int irq;
>> +	struct work_struct free_irq_work;
>> +	unsigned long last_unhandled_irq;
>> +	unsigned int unhandled_irqs;
>>  	unsigned int int_mask;
>>  	unsigned long flags;
>>  	void __iomem *ilb_base_addr;
>>
>> base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1
>> --
>> 2.25.1
>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> Looks very good, thank you.


Great, thanks a lot for the review(s)!

Regards,
Lino


