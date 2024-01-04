Return-Path: <linux-kernel+bounces-16303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8B4823C7F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D423B22282
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB641F93C;
	Thu,  4 Jan 2024 07:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="rbq3Ks1h"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DDE1F959;
	Thu,  4 Jan 2024 07:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1704352269; x=1704957069; i=w_armin@gmx.de;
	bh=78Xb27rHymDdm3m/9/ReY0W1tCUIfslbc8yhLxW5Go4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=rbq3Ks1h+RHSSeZkgZpyw95ZexqqVTxQdTCAI64KACr05VxGx9Fg0y8Bg7PNmSO5
	 e1rhwy0dFx0UW0cvOJQBiN8roVBQVrj/1B2aNs986edGYIgHNss3vxh8r6JDgwdde
	 41kHSFBRlJOsCyn6rSj1nXmc2Wv5Kl73JK40MooMfBVU5Yw3RO4oe9v0SwnH/0ft1
	 cP6Q2XlHqp+6zybQn+s+lHAYEvApWdWAIrRuFaK+vL60v/gE36lKuphGQ8TEZeUU7
	 igpKU6nXWXo9CCyoraHTzmcZVzUr08Cl/1IYh5D3IvQfDwSkJBMcD8jEEClrx7lT8
	 xWE01Am9BJBm198gpQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhD2Y-1qhG6Z1mr4-00eJm9; Thu, 04
 Jan 2024 08:11:09 +0100
Message-ID: <4efe51b7-cdbd-43ca-a6c7-abc6ac93d718@gmx.de>
Date: Thu, 4 Jan 2024 08:11:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: (acpi_power_meter) Ensure IPMI space handler is
 ready on Dell systems
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: jdelvare@suse.com, linux@roeck-us.net,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20231227040401.548977-1-kai.heng.feng@canonical.com>
 <430501f6-47fc-49c8-8db8-9cbdf2ba1ae5@gmx.de>
 <CAAd53p7-NkOa3QPD0szmC0OcHc1VGMBudVbAqWVstvqVm-kwWg@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAAd53p7-NkOa3QPD0szmC0OcHc1VGMBudVbAqWVstvqVm-kwWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JrSN+Di497nPfM7kwf6MDlfs0gSEtxjAPobihfDO+bIESclzbR+
 14y3aZeFYBsrUnXwZnA8X8CiTK1BsJwa01vTE5rqw+sMYZcPRz/+SazSzcu8hxgX9vKHBqL
 NQ1C7XnpELSLfNU6q1vpgEfsNqtx1DKK3VkUwhdPdMs/vcX00h02rNskkc1IyEyWToD3sNY
 dfkpVhRLlEph8rr8yVFkQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YQHGDss/Qnw=;Ctme1hpSSrpUhnO7aCy580DULFk
 DDooF35581G27KWYcjrsdfJdAvb+hUm2HNieduIUIC0vj3TmbCVV7p4M9BPPcT3kCuZfmt8NN
 SLcyVyjUFRvyIn4d8FunXf+Ez7jZp+ulRDZyBK30wMf18w3T6agu4Rm7G0aUeB47S2ULBItYK
 fbAK38oAluaE1odNkDPxaQLAXSp3OL5pfQ4vd4Y1kIA1I4yziA3kef0W7IrZtRzb8iTbPa6qU
 JH/NB4lzG/4Z2yJtf9uP5QsSLikAVBYHMeX2hcuUoqWbrtRBY9SBfVHuopDd28geaxb+W3bi+
 S8eUNtxGcwFa4jaRFGva2ZnFIjmViRAcGAySsqMYUpS89YV7TTJ5J4UwlMM4/6sUnTm+i5xBW
 MGCY199uotNtFD2Gyyx3067Zso1Gc83GgQTXY+hXTWMyk8a64CBYn4NOFE7lWSzkYqdiUUW3w
 PqPhvUpfmT6r8JvjjsBeb8UBvOOT012iJ2H4F/TgKwakB+qRHoA84F+1TeUfeLb5Ol22PusqD
 ba24sLbGy8zcJAxQZjXDyIXLebq9GHUtKn+9XQP9vmAxyw8xRbpr7UaxdKBaBS1s0Vc+Ohd4R
 tfbhHZYqejj5XN7/dx8Iv5bdXT1Vb6G9WRO74ArS1GXZF5Q+yU7DPTT8XflGtu/MQF4b9uVvt
 Y/bWvq7aksVVmVAu89wBf7RjftOLVvkTsQ+XgAkJm7PNG+MrfQ22R9iFh9C/Y5Yo1Bk5xxwcm
 kdq3G/l04sB1v1LGkRRLDl2Qz52CtsuZm5y7aBJKSv7GAOJ9zC0rNEVxxc2d61Qd2Up32S0Bc
 ZFIEP/PImOrhbxQJplF9yS+De4ZN6ayy+AOhIwi2J1+AsMOcJntb3k4gVZrt64AAhkCADvTud
 NX/oNO5OXe6TwXzqaZ7Bh1Nm7opPJFOi4Hdcap+uILMU2ZLO0kTNpgIQKvZhvWIOESp3Dxz8a
 N/6Azlt+U+W1UTQ6LC/PXExf8cY=

Am 04.01.24 um 03:14 schrieb Kai-Heng Feng:

> On Thu, Jan 4, 2024 at 5:23=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote=
:
>> Am 27.12.23 um 05:04 schrieb Kai-Heng Feng:
>>
>>> The following error can be observed at boot:
>>> [    3.717920] ACPI Error: No handler for Region [SYSI] (00000000ab9e6=
2c5) [IPMI] (20230628/evregion-130)
>>> [    3.717928] ACPI Error: Region IPMI (ID=3D7) has no handler (202306=
28/exfldio-261)
>>>
>>> [    3.717936] No Local Variables are initialized for Method [_GHL]
>>>
>>> [    3.717938] No Arguments are initialized for method [_GHL]
>>>
>>> [    3.717940] ACPI Error: Aborting method \_SB.PMI0._GHL due to previ=
ous error (AE_NOT_EXIST) (20230628/psparse-529)
>>> [    3.717949] ACPI Error: Aborting method \_SB.PMI0._PMC due to previ=
ous error (AE_NOT_EXIST) (20230628/psparse-529)
>>> [    3.717957] ACPI: \_SB_.PMI0: _PMC evaluation failed: AE_NOT_EXIST
>>>
>>> On Dell systems several methods of acpi_power_meter access variables i=
n
>>> IPMI region [0], so wait until IPMI space handler is installed by
>>> acpi_ipmi and also wait until SMI is selected to make the space handle=
r
>>> fully functional.
>> Hi,
>>
>> could it be that the ACPI firmware expects us to support the ACPI SPMI =
table?
>> The ACPI SPMI table contains a description of the IPMI interface used b=
y the platform,
>> and its purpose seems to be similar to the ACPI ECDT table in that it a=
llows the OS
>> to access IPMI resources before all ACPI namespaces are enumerated.
>>
>> Adding support for this table would solve this problem without stalling=
 the boot
>> process by waiting for the ACPI IPMI device to probe. It would also avo=
id any issues
>> should the ACPI IPMI device be removed later.
> Hi, the ACPI firmware on the system doesn't have SPMI table:
> $ ls /sys/firmware/acpi/tables/
> APIC  BERT  data  DMAR  DSDT  dynamic  EINJ  ERST  FACP  FACS  HEST
> HMAT  HPET  MCFG  MIGT  MSCT  NBFT  OEM4  SLIC  SLIT  SRAT  SSDT1
> SSDT2  SSDT3  SSDT4  SSDT5  SSDT6  TPM2  UEFI1  UEFI2  VFCT  WSMT
>
> Kai-Heng

Thanks for checking this, in this case you might ignore my suggestion abov=
e.

Armin Wolf

>> Armin Wolf
>>
>>> [0] https://www.dell.com/support/manuals/en-us/redhat-enterprise-linux=
-v8.0/rhel8_rn_pub/advanced-configuration-and-power-interface-acpi-error-m=
essages-displayed-in-dmesg?guid=3Dguid-0d5ae482-1977-42cf-b417-3ed5c3f5ee6=
2
>>>
>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> ---
>>> v2:
>>>    - Use completion instead of request_module().
>>>
>>>    drivers/acpi/acpi_ipmi.c         | 13 ++++++++++++-
>>>    drivers/hwmon/acpi_power_meter.c |  4 ++++
>>>    include/acpi/acpi_bus.h          |  4 ++++
>>>    3 files changed, 20 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
>>> index 0555f68c2dfd..2ea8b7e6cebf 100644
>>> --- a/drivers/acpi/acpi_ipmi.c
>>> +++ b/drivers/acpi/acpi_ipmi.c
>>> @@ -23,6 +23,8 @@ MODULE_LICENSE("GPL");
>>>    #define IPMI_TIMEOUT                        (5000)
>>>    #define ACPI_IPMI_MAX_MSG_LENGTH    64
>>>
>>> +static struct completion smi_selected;
>>> +
>>>    struct acpi_ipmi_device {
>>>        /* the device list attached to driver_data.ipmi_devices */
>>>        struct list_head head;
>>> @@ -463,8 +465,10 @@ static void ipmi_register_bmc(int iface, struct d=
evice *dev)
>>>                if (temp->handle =3D=3D handle)
>>>                        goto err_lock;
>>>        }
>>> -     if (!driver_data.selected_smi)
>>> +     if (!driver_data.selected_smi) {
>>>                driver_data.selected_smi =3D ipmi_device;
>>> +             complete(&smi_selected);
>>> +     }
>>>        list_add_tail(&ipmi_device->head, &driver_data.ipmi_devices);
>>>        mutex_unlock(&driver_data.ipmi_lock);
>>>
>>> @@ -578,10 +582,17 @@ acpi_ipmi_space_handler(u32 function, acpi_physi=
cal_address address,
>>>        return status;
>>>    }
>>>
>>> +void wait_for_acpi_ipmi(void)
>>> +{
>>> +     wait_for_completion_interruptible_timeout(&smi_selected, 2 * HZ)=
;
>>> +}
>>> +EXPORT_SYMBOL_GPL(wait_for_acpi_ipmi);
>>> +
>>>    static int __init acpi_ipmi_init(void)
>>>    {
>>>        int result;
>>>        acpi_status status;
>>> +     init_completion(&smi_selected);
>>>
>>>        if (acpi_disabled)
>>>                return 0;
>>> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_pow=
er_meter.c
>>> index 703666b95bf4..acaf1ae68dc8 100644
>>> --- a/drivers/hwmon/acpi_power_meter.c
>>> +++ b/drivers/hwmon/acpi_power_meter.c
>>> @@ -883,6 +883,10 @@ static int acpi_power_meter_add(struct acpi_devic=
e *device)
>>>        strcpy(acpi_device_class(device), ACPI_POWER_METER_CLASS);
>>>        device->driver_data =3D resource;
>>>
>>> +     if (dmi_match(DMI_SYS_VENDOR, "Dell Inc.") &&
>>> +         acpi_dev_get_first_match_dev("IPI0001", NULL, -1))
>>> +             wait_for_acpi_ipmi();
>>> +
>>>        res =3D read_capabilities(resource);
>>>        if (res)
>>>                goto exit_free;
>>> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
>>> index 1216d72c650f..ed59fb89721e 100644
>>> --- a/include/acpi/acpi_bus.h
>>> +++ b/include/acpi/acpi_bus.h
>>> @@ -655,6 +655,7 @@ bool acpi_device_override_status(struct acpi_devic=
e *adev, unsigned long long *s
>>>    bool acpi_quirk_skip_acpi_ac_and_battery(void);
>>>    int acpi_install_cmos_rtc_space_handler(acpi_handle handle);
>>>    void acpi_remove_cmos_rtc_space_handler(acpi_handle handle);
>>> +void wait_for_acpi_ipmi(void);
>>>    #else
>>>    static inline bool acpi_device_override_status(struct acpi_device *=
adev,
>>>                                               unsigned long long *stat=
us)
>>> @@ -672,6 +673,9 @@ static inline int acpi_install_cmos_rtc_space_hand=
ler(acpi_handle handle)
>>>    static inline void acpi_remove_cmos_rtc_space_handler(acpi_handle h=
andle)
>>>    {
>>>    }
>>> +static inline void wait_for_acpi_ipmi(void)
>>> +{
>>> +}
>>>    #endif
>>>
>>>    #if IS_ENABLED(CONFIG_X86_ANDROID_TABLETS)

