Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B012E7E1A6D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjKFGoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjKFGo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:44:26 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C847210B;
        Sun,  5 Nov 2023 22:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699253036; x=1699857836; i=w_armin@gmx.de;
        bh=QFbGf3diOYzTCMO91fm6tDHFcxT7ey2Z/fBZeipyGok=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=kCN565ENaoNv96ef+F8tJxUM9ySeINFI86IcYLnCngDBGx6IbKYV7bnWYHofqn9Y
         sCE+KTnxJBkQIfoL6fQ/CAO9zz+P469/S9kowM12QxI3mhiFywwX/69XL0WIsOm2p
         BdEZzfObkTnT02kSW4UjBvNWRrcRo/GDaBr/XGdw3EOk1302C59gM7CsUVPmruYa4
         PnfFO9QzD49/MFtc0nkmUX9nkmP4XMxHGHXl69+nZFiTdGeFepI7SglZ+i60yCvDS
         cEuYQ8Bc1k4BU7DVcpSwW8ymI17lOqgO3rhYwR2I//Zm6dDsWvjvjIuQrvieoTqMd
         ucrer6FYuAAb4/PXAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MtwZ4-1rGJn62VxM-00uGDE; Mon, 06 Nov 2023 07:43:56 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
        linux@roeck-us.net, platform-driver-x86@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/9] hwmon: (dell-smm) Prepare for multiple SMM calling backends
Date:   Mon,  6 Nov 2023 07:43:43 +0100
Message-Id: <20231106064351.42347-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231106064351.42347-1-W_Armin@gmx.de>
References: <20231106064351.42347-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/AFStnN/0keMHF/B7mWdW6LL037VY2sduMnkK4cAZsmi7Yysfzb
 sBsECo8VWZiUcSpclyPFVsps6ElSthVu1bp8VTfiBhFCO7IppLdOJhYCjHODNmwre1C9SaV
 udCKowzpLO/c8FaaLVSdDF97A383/neIHzTBgfklq9MxzcbBH0T7RIxcT19/X0oC03DaiR6
 4shWgKhNnn7HDmWlYTU9A==
UI-OutboundReport: notjunk:1;M01:P0:PmMg9WPCF+E=;JgAYMMoBxI384F0EuBCPvPGv3mA
 ZvOEP7rj7UPrOMJykO5gTp9GpSMSCXzNVgk7BdSABPWhrcp2LN0HfFQwr1prejyfKu2CzK4Pe
 XVFwbot3t59v3b9a7Tt0YHTSWKBNbghjhCwb5J5MLQnazNsKeQFlb9ydWaiRTOkjGnRYav4Fs
 lsWWli0nZwaDvObeheRb5CaWWwI5Qc2L4XYWKZIxTD1YxcJwq7yi+GAhA2kxr/dR8KaEErzA7
 +JcHyl3ctNq2y87eTu7MwVZJyZC9+2ORnghT1lH9A2esK5xYkWaAcilDgguhn0wSpX3NP0RWj
 SXEaW8wbvKR7OL/OEqWizi4Yl4itzvEKPOBSRhZVjpcoTXi2sYTJasQmVFxe9QptrmEJLUPMy
 yuRvEDx2+EhY6sP0GHUeuNC+NsblqUQStDVqGRZ2cN6YWxyxTiG7JKm3Z8dSg+WCTU8sESayz
 xvwLLbBmHeRF+OIiiKGAsOgRSmlhc4KM+KVrzN+mU6Q4x+XPf+BsTsRu/Wffuo9KVpzTg9/rH
 +x5RVC5caxg6oO/+fib4ZPXDFUmqdBwG1pVyjoTMMmHhdkt3HwABr3tXsJqdLFfDU+aDVGiPw
 frDLSuKpoVhfXchqLbP4mgCSzlc2JICnT+YHnx6MFtijhPu/5cwmAuAWJPIwKKOrQ3CA1uYRN
 wBWnsfj3/TWigfPx/HudJKVpxBf+o3cSsIgRjToiWqQprMlBBkxGdWPpHkpFtpghGGWLBoUpK
 ChYQLpez6BZb0FqhWPzc9xhmpjQYOvGDNmfiDf8rHA2WB8JppFKqD3cfQ3S1icPbX8HF8Qu22
 VjvJsV18x5t692J/axbwVn/XCOFLB6nbV8Hvjj5m+/Q97ziTzeuslQlQxMUhjDB2Wr+8c6wxr
 Wuhn0eGfA4WgOoubm8AGLEuEMt81oOyZBM6uVtoaHdJJ673ScRdexyf9vnneoKvTbxI6X1kXX
 WAqs9cEbIhwYRCf7bagZzKNNLR0=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modern Dell machines support multiple ways to issue an SMM call.
Prepare support for those by introducing dell_smm_ops, which is
used by dell_smm_call() to perform a SMM call. Each SMM backend
needs to provide a dell_smm_ops structure.

Tested-by: <serverror@serverror.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 131 ++++++++++++++++++++-------------
 1 file changed, 79 insertions(+), 52 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 44aaf9b9191d..a3273780f7c3 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -69,6 +69,20 @@
 #define DELL_SMM_NO_TEMP	10
 #define DELL_SMM_NO_FANS	3

+struct smm_regs {
+	int eax;
+	int ebx;
+	int ecx;
+	int edx;
+	int esi;
+	int edi;
+};
+
+struct dell_smm_ops {
+	struct device *smm_dev;
+	int (*smm_call)(struct device *smm_dev, struct smm_regs *regs);
+};
+
 struct dell_smm_data {
 	struct mutex i8k_mutex; /* lock for sensors writes */
 	char bios_version[4];
@@ -84,6 +98,7 @@ struct dell_smm_data {
 	bool fan[DELL_SMM_NO_FANS];
 	int fan_type[DELL_SMM_NO_FANS];
 	int *fan_nominal_speed[DELL_SMM_NO_FANS];
+	const struct dell_smm_ops *ops;
 };

 struct dell_smm_cooling_data {
@@ -123,15 +138,6 @@ static uint fan_max;
 module_param(fan_max, uint, 0);
 MODULE_PARM_DESC(fan_max, "Maximum configurable fan speed (default: autod=
etect)");

-struct smm_regs {
-	unsigned int eax;
-	unsigned int ebx;
-	unsigned int ecx;
-	unsigned int edx;
-	unsigned int esi;
-	unsigned int edi;
-};
-
 static const char * const temp_labels[] =3D {
 	"CPU",
 	"GPU",
@@ -171,12 +177,8 @@ static inline const char __init *i8k_get_dmi_data(int=
 field)
  */
 static int i8k_smm_func(void *par)
 {
-	ktime_t calltime =3D ktime_get();
 	struct smm_regs *regs =3D par;
-	int eax =3D regs->eax;
-	int ebx =3D regs->ebx;
 	unsigned char carry;
-	long long duration;

 	/* SMM requires CPU 0 */
 	if (smp_processor_id() !=3D 0)
@@ -193,14 +195,7 @@ static int i8k_smm_func(void *par)
 		       "+S" (regs->esi),
 		       "+D" (regs->edi));

-	duration =3D ktime_us_delta(ktime_get(), calltime);
-	pr_debug("smm(0x%.4x 0x%.4x) =3D 0x%.4x carry: %d (took %7lld usecs)\n",
-		 eax, ebx, regs->eax & 0xffff, carry, duration);
-
-	if (duration > DELL_SMM_MAX_DURATION)
-		pr_warn_once("SMM call took %lld usecs!\n", duration);
-
-	if (carry || (regs->eax & 0xffff) =3D=3D 0xffff || regs->eax =3D=3D eax)
+	if (carry)
 		return -EINVAL;

 	return 0;
@@ -209,7 +204,7 @@ static int i8k_smm_func(void *par)
 /*
  * Call the System Management Mode BIOS.
  */
-static int i8k_smm(struct smm_regs *regs)
+static int i8k_smm_call(struct device *dummy, struct smm_regs *regs)
 {
 	int ret;

@@ -220,6 +215,37 @@ static int i8k_smm(struct smm_regs *regs)
 	return ret;
 }

+static const struct dell_smm_ops i8k_smm_ops =3D {
+	.smm_call =3D i8k_smm_call,
+};
+
+static int dell_smm_call(const struct dell_smm_ops *ops, struct smm_regs =
*regs)
+{
+	int eax =3D regs->eax;
+	int ebx =3D regs->ebx;
+	long long duration;
+	ktime_t calltime;
+	int ret;
+
+	calltime =3D ktime_get();
+	ret =3D ops->smm_call(ops->smm_dev, regs);
+	duration =3D ktime_us_delta(ktime_get(), calltime);
+
+	pr_debug("SMM(0x%.4x 0x%.4x) =3D 0x%.4x status: %d (took %7lld usecs)\n"=
,
+		 eax, ebx, regs->eax & 0xffff, ret, duration);
+
+	if (duration > DELL_SMM_MAX_DURATION)
+		pr_warn_once("SMM call took %lld usecs!\n", duration);
+
+	if (ret < 0)
+		return ret;
+
+	if ((regs->eax & 0xffff) =3D=3D 0xffff || regs->eax =3D=3D eax)
+		return -EINVAL;
+
+	return 0;
+}
+
 /*
  * Read the fan status.
  */
@@ -233,7 +259,7 @@ static int i8k_get_fan_status(const struct dell_smm_da=
ta *data, u8 fan)
 	if (data->disallow_fan_support)
 		return -EINVAL;

-	return i8k_smm(&regs) ? : regs.eax & 0xff;
+	return dell_smm_call(data->ops, &regs) ? : regs.eax & 0xff;
 }

 /*
@@ -249,7 +275,7 @@ static int i8k_get_fan_speed(const struct dell_smm_dat=
a *data, u8 fan)
 	if (data->disallow_fan_support)
 		return -EINVAL;

-	return i8k_smm(&regs) ? : (regs.eax & 0xffff) * data->i8k_fan_mult;
+	return dell_smm_call(data->ops, &regs) ? : (regs.eax & 0xffff) * data->i=
8k_fan_mult;
 }

 /*
@@ -265,7 +291,7 @@ static int _i8k_get_fan_type(const struct dell_smm_dat=
a *data, u8 fan)
 	if (data->disallow_fan_support || data->disallow_fan_type_call)
 		return -EINVAL;

-	return i8k_smm(&regs) ? : regs.eax & 0xff;
+	return dell_smm_call(data->ops, &regs) ? : regs.eax & 0xff;
 }

 static int i8k_get_fan_type(struct dell_smm_data *data, u8 fan)
@@ -290,7 +316,7 @@ static int __init i8k_get_fan_nominal_speed(const stru=
ct dell_smm_data *data, u8
 	if (data->disallow_fan_support)
 		return -EINVAL;

-	return i8k_smm(&regs) ? : (regs.eax & 0xffff);
+	return dell_smm_call(data->ops, &regs) ? : (regs.eax & 0xffff);
 }

 /*
@@ -304,7 +330,7 @@ static int i8k_enable_fan_auto_mode(const struct dell_=
smm_data *data, bool enabl
 		return -EINVAL;

 	regs.eax =3D enable ? data->auto_fan : data->manual_fan;
-	return i8k_smm(&regs);
+	return dell_smm_call(data->ops, &regs);
 }

 /*
@@ -320,35 +346,35 @@ static int i8k_set_fan(const struct dell_smm_data *d=
ata, u8 fan, int speed)
 	speed =3D (speed < 0) ? 0 : ((speed > data->i8k_fan_max) ? data->i8k_fan=
_max : speed);
 	regs.ebx =3D fan | (speed << 8);

-	return i8k_smm(&regs);
+	return dell_smm_call(data->ops, &regs);
 }

-static int __init i8k_get_temp_type(u8 sensor)
+static int __init i8k_get_temp_type(const struct dell_smm_data *data, u8 =
sensor)
 {
 	struct smm_regs regs =3D {
 		.eax =3D I8K_SMM_GET_TEMP_TYPE,
 		.ebx =3D sensor,
 	};

-	return i8k_smm(&regs) ? : regs.eax & 0xff;
+	return dell_smm_call(data->ops, &regs) ? : regs.eax & 0xff;
 }

 /*
  * Read the cpu temperature.
  */
-static int _i8k_get_temp(u8 sensor)
+static int _i8k_get_temp(const struct dell_smm_data *data, u8 sensor)
 {
 	struct smm_regs regs =3D {
 		.eax =3D I8K_SMM_GET_TEMP,
 		.ebx =3D sensor,
 	};

-	return i8k_smm(&regs) ? : regs.eax & 0xff;
+	return dell_smm_call(data->ops, &regs) ? : regs.eax & 0xff;
 }

-static int i8k_get_temp(u8 sensor)
+static int i8k_get_temp(const struct dell_smm_data *data, u8 sensor)
 {
-	int temp =3D _i8k_get_temp(sensor);
+	int temp =3D _i8k_get_temp(data, sensor);

 	/*
 	 * Sometimes the temperature sensor returns 0x99, which is out of range.
@@ -359,7 +385,7 @@ static int i8k_get_temp(u8 sensor)
 	 */
 	if (temp =3D=3D 0x99) {
 		msleep(100);
-		temp =3D _i8k_get_temp(sensor);
+		temp =3D _i8k_get_temp(data, sensor);
 	}
 	/*
 	 * Return -ENODATA for all invalid temperatures.
@@ -375,12 +401,12 @@ static int i8k_get_temp(u8 sensor)
 	return temp;
 }

-static int __init i8k_get_dell_signature(int req_fn)
+static int __init dell_smm_get_signature(const struct dell_smm_ops *ops, =
int req_fn)
 {
 	struct smm_regs regs =3D { .eax =3D req_fn, };
 	int rc;

-	rc =3D i8k_smm(&regs);
+	rc =3D dell_smm_call(ops, &regs);
 	if (rc < 0)
 		return rc;

@@ -392,12 +418,12 @@ static int __init i8k_get_dell_signature(int req_fn)
 /*
  * Read the Fn key status.
  */
-static int i8k_get_fn_status(void)
+static int i8k_get_fn_status(const struct dell_smm_data *data)
 {
 	struct smm_regs regs =3D { .eax =3D I8K_SMM_FN_STATUS, };
 	int rc;

-	rc =3D i8k_smm(&regs);
+	rc =3D dell_smm_call(data->ops, &regs);
 	if (rc < 0)
 		return rc;

@@ -416,12 +442,12 @@ static int i8k_get_fn_status(void)
 /*
  * Read the power status.
  */
-static int i8k_get_power_status(void)
+static int i8k_get_power_status(const struct dell_smm_data *data)
 {
 	struct smm_regs regs =3D { .eax =3D I8K_SMM_POWER_STATUS, };
 	int rc;

-	rc =3D i8k_smm(&regs);
+	rc =3D dell_smm_call(data->ops, &regs);
 	if (rc < 0)
 		return rc;

@@ -464,15 +490,15 @@ static long i8k_ioctl(struct file *fp, unsigned int =
cmd, unsigned long arg)

 		return 0;
 	case I8K_FN_STATUS:
-		val =3D i8k_get_fn_status();
+		val =3D i8k_get_fn_status(data);
 		break;

 	case I8K_POWER_STATUS:
-		val =3D i8k_get_power_status();
+		val =3D i8k_get_power_status(data);
 		break;

 	case I8K_GET_TEMP:
-		val =3D i8k_get_temp(0);
+		val =3D i8k_get_temp(data, 0);
 		break;

 	case I8K_GET_SPEED:
@@ -539,14 +565,14 @@ static int i8k_proc_show(struct seq_file *seq, void =
*offset)
 	int fn_key, cpu_temp, ac_power;
 	int left_fan, right_fan, left_speed, right_speed;

-	cpu_temp	=3D i8k_get_temp(0);				/* 11100 =C2=B5s */
+	cpu_temp	=3D i8k_get_temp(data, 0);			/* 11100 =C2=B5s */
 	left_fan	=3D i8k_get_fan_status(data, I8K_FAN_LEFT);	/*   580 =C2=B5s */
 	right_fan	=3D i8k_get_fan_status(data, I8K_FAN_RIGHT);	/*   580 =C2=B5s =
*/
 	left_speed	=3D i8k_get_fan_speed(data, I8K_FAN_LEFT);	/*   580 =C2=B5s *=
/
 	right_speed	=3D i8k_get_fan_speed(data, I8K_FAN_RIGHT);	/*   580 =C2=B5s=
 */
-	fn_key		=3D i8k_get_fn_status();				/*   750 =C2=B5s */
+	fn_key		=3D i8k_get_fn_status(data);			/*   750 =C2=B5s */
 	if (power_status)
-		ac_power =3D i8k_get_power_status();			/* 14700 =C2=B5s */
+		ac_power =3D i8k_get_power_status(data);			/* 14700 =C2=B5s */
 	else
 		ac_power =3D -1;

@@ -665,7 +691,7 @@ static umode_t dell_smm_is_visible(const void *drvdata=
, enum hwmon_sensor_types
 		switch (attr) {
 		case hwmon_temp_input:
 			/* _i8k_get_temp() is fine since we do not care about the actual value=
 */
-			if (data->temp_type[channel] >=3D 0 || _i8k_get_temp(channel) >=3D 0)
+			if (data->temp_type[channel] >=3D 0 || _i8k_get_temp(data, channel) >=
=3D 0)
 				return 0444;

 			break;
@@ -747,7 +773,7 @@ static int dell_smm_read(struct device *dev, enum hwmo=
n_sensor_types type, u32 a
 	case hwmon_temp:
 		switch (attr) {
 		case hwmon_temp_input:
-			ret =3D i8k_get_temp(channel);
+			ret =3D i8k_get_temp(data, channel);
 			if (ret < 0)
 				return ret;

@@ -994,7 +1020,7 @@ static int __init dell_smm_init_hwmon(struct device *=
dev)
 	u8 i;

 	for (i =3D 0; i < DELL_SMM_NO_TEMP; i++) {
-		data->temp_type[i] =3D i8k_get_temp_type(i);
+		data->temp_type[i] =3D i8k_get_temp_type(data, i);
 		if (data->temp_type[i] < 0)
 			continue;

@@ -1353,6 +1379,7 @@ static int __init dell_smm_probe(struct platform_dev=
ice *pdev)

 	mutex_init(&data->i8k_mutex);
 	platform_set_drvdata(pdev, data);
+	data->ops =3D &i8k_smm_ops;

 	if (dmi_check_system(i8k_blacklist_fan_support_dmi_table)) {
 		if (!force) {
@@ -1445,8 +1472,8 @@ static int __init i8k_init(void)
 	/*
 	 * Get SMM Dell signature
 	 */
-	if (i8k_get_dell_signature(I8K_SMM_GET_DELL_SIG1) &&
-	    i8k_get_dell_signature(I8K_SMM_GET_DELL_SIG2)) {
+	if (dell_smm_get_signature(&i8k_smm_ops, I8K_SMM_GET_DELL_SIG1) &&
+	    dell_smm_get_signature(&i8k_smm_ops, I8K_SMM_GET_DELL_SIG2)) {
 		if (!force)
 			return -ENODEV;

=2D-
2.39.2

