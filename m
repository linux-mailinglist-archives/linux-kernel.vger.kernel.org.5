Return-Path: <linux-kernel+bounces-51856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D2484901E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0902849A5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 19:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2664D25574;
	Sun,  4 Feb 2024 19:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CeINcSds"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099D2250F1;
	Sun,  4 Feb 2024 19:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707075119; cv=none; b=f3aFQyRNFk0zjNHr4laCTJO/xZQDXfIcZL38GuGdSK4T/KSMY7mRM/0lKO9MkP9Gxv66KFDmYS4aEobH+wZjqzR4Sq7vOieuQ4UUr+IKX5Hn7vhBnVH3P1fEnRueviG7/Msay7ky5VyLglY9QXEhhDAqrk5/V/6nJjYun2Bb0cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707075119; c=relaxed/simple;
	bh=n5XSk91kCslNCoYl44I0uBsnPT+dMeWqMwNXAzbHByc=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lsaRV9QQP7e31IFnTky6nM+VN0tZRtcZg7y5/YOiF74jKamKDn7wkcVfVjTnm48tAxilBUHUcElwU6rR7zQJu1I3G7j+Gjw4r48Gv/SaFXOqDEQXSDLC5q9vmPj6y7MDkvvOdjOlitb6OeO96Coq90cBDRrxBRWhk8MXhjNVP/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CeINcSds; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 414JV1D9127371;
	Sun, 4 Feb 2024 13:31:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707075061;
	bh=TaSPTXlkDftBhODwH0N+U0NVhn/CexktNfHvrkQWmrs=;
	h=From:To:CC:Subject:In-Reply-To:References:Date;
	b=CeINcSds7ejqXCg7Bembi14ln3Ss+0mOLHeRealRcIaQF4wa7Z6P2wahiGWB1y82y
	 MhJV4AnHJ8cG0QfBIQqWo55/nxeCoLrlVbK0xtXY2VcGORvnIYqa1jRGI92Rf35Qfd
	 J4plz1Aj3GEmCjDUzGXRIXc3scaRUut+7SBnDk1Y=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 414JV1DL090422
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 4 Feb 2024 13:31:01 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 4
 Feb 2024 13:31:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 4 Feb 2024 13:31:01 -0600
Received: from localhost (kamlesh.dhcp.ti.com [172.24.227.123])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 414JV0K1093538;
	Sun, 4 Feb 2024 13:31:00 -0600
From: Kamlesh Gurudasani <kamlesh@ti.com>
To: Gaurav Kashyap <quic_gaurkash@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <andersson@kernel.org>, <ebiggers@google.com>,
        <neil.armstrong@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <robh+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <kernel@quicinc.com>, <linux-crypto@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_omprsing@quicinc.com>,
        <quic_nguyenb@quicinc.com>, <bartosz.golaszewski@linaro.org>,
        <konrad.dybcio@linaro.org>, <ulf.hansson@linaro.org>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <mani@kernel.org>,
        <davem@davemloft.net>, <herbert@gondor.apana.org.au>,
        Gaurav Kashyap <quic_gaurkash@quicinc.com>
Subject: Re: [EXTERNAL] [PATCH v4 05/15] soc: qcom: ice: support for
 hardware wrapped keys
In-Reply-To: <20240127232436.2632187-6-quic_gaurkash@quicinc.com>
References: <20240127232436.2632187-1-quic_gaurkash@quicinc.com>
 <20240127232436.2632187-6-quic_gaurkash@quicinc.com>
Date: Mon, 5 Feb 2024 01:00:59 +0530
Message-ID: <87h6ioyqks.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Gaurav Kashyap <quic_gaurkash@quicinc.com> writes:

> This message was sent from outside of Texas Instruments. 
> Do not click links or open attachments unless you recognize the source of this email and know the content is safe. 
>  
> Now that HWKM support is added to ICE, extend the ICE
> driver to support hardware wrapped keys programming coming
> in from the storage controllers (ufs and emmc). This is
> similar to standard keys where the call is forwarded to
> Trustzone, however certain wrapped key and HWKM specific
> actions has to be performed around the SCM calls.
>
> Derive software secret support is also added by forwarding the
> call to the corresponding scm api.
>
> Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/soc/qcom/ice.c | 119 +++++++++++++++++++++++++++++++++++++----
>  include/soc/qcom/ice.h |   4 ++
>  2 files changed, 112 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
> index c718e8153b23..c3b852269dca 100644
> --- a/drivers/soc/qcom/ice.c
> +++ b/drivers/soc/qcom/ice.c
> @@ -27,6 +27,8 @@
>  #define QCOM_ICE_REG_BIST_STATUS		0x0070
>  #define QCOM_ICE_REG_ADVANCED_CONTROL		0x1000
>  #define QCOM_ICE_REG_CONTROL			0x0
> +#define QCOM_ICE_LUT_KEYS_CRYPTOCFG_R16		0x4040
> +
>  /* QCOM ICE HWKM registers */
>  #define QCOM_ICE_REG_HWKM_TZ_KM_CTL			0x1000
>  #define QCOM_ICE_REG_HWKM_TZ_KM_STATUS			0x1004
> @@ -48,6 +50,8 @@
>  #define QCOM_ICE_FORCE_HW_KEY0_SETTING_MASK	0x2
>  #define QCOM_ICE_FORCE_HW_KEY1_SETTING_MASK	0x4
>  
> +#define QCOM_ICE_LUT_KEYS_CRYPTOCFG_OFFSET	0x80
> +
>  #define QCOM_ICE_HWKM_REG_OFFSET	0x8000
>  #define HWKM_OFFSET(reg)		((reg) + QCOM_ICE_HWKM_REG_OFFSET)
>  
> @@ -68,6 +72,16 @@ struct qcom_ice {
>  	bool hwkm_init_complete;
>  };
>  
> +union crypto_cfg {
> +	__le32 regval;
> +	struct {
> +		u8 dusize;
> +		u8 capidx;
> +		u8 reserved;
> +		u8 cfge;
> +	};
> +};
> +
>  static bool qcom_ice_check_supported(struct qcom_ice *ice)
>  {
>  	u32 regval = qcom_ice_readl(ice, QCOM_ICE_REG_VERSION);
> @@ -273,6 +287,51 @@ int qcom_ice_suspend(struct qcom_ice *ice)
>  }
>  EXPORT_SYMBOL_GPL(qcom_ice_suspend);
>  
> +/*
> + * HW dictates the internal mapping between the ICE and HWKM slots,
> + * which are different for different versions, make the translation
> + * here. For v1 however, the translation is done in trustzone.
> + */
> +static int translate_hwkm_slot(struct qcom_ice *ice, int slot)
> +{
> +	return (ice->hwkm_version == 1) ? slot : (slot * 2);
> +}
> +
> +static int qcom_ice_program_wrapped_key(struct qcom_ice *ice,
> +					const struct blk_crypto_key *key,
> +					u8 data_unit_size, int slot)
> +{
> +	union crypto_cfg cfg;
> +	int hwkm_slot;
> +	int err;
> +
> +	hwkm_slot = translate_hwkm_slot(ice, slot);
> +
> +	memset(&cfg, 0, sizeof(cfg));
> +	cfg.dusize = data_unit_size;
> +	cfg.capidx = QCOM_SCM_ICE_CIPHER_AES_256_XTS;
> +	cfg.cfge = 0x80;
> +
This is a clever use of union, writing from one member and
reading from inactive member.

I hope this a common practice in linux(being used in some other module
already) or fits the standard of C or will give deterministic result on
other compilers as well. Thanks.

Regards,
Kamlesh

> +	/* Clear CFGE */
> +	qcom_ice_writel(ice, 0x0, QCOM_ICE_LUT_KEYS_CRYPTOCFG_R16 +
> +				  QCOM_ICE_LUT_KEYS_CRYPTOCFG_OFFSET * slot);
> +
> +	/* Call trustzone to program the wrapped key using hwkm */
> +	err = qcom_scm_ice_set_key(hwkm_slot, key->raw, key->size,
> +				   QCOM_SCM_ICE_CIPHER_AES_256_XTS, data_unit_size);
> +	if (err) {
> +		pr_err("%s:SCM call Error: 0x%x slot %d\n", __func__, err,
> +		       slot);
> +		return err;
> +	}
> +
> +	/* Enable CFGE after programming key */
> +	qcom_ice_writel(ice, cfg.regval, QCOM_ICE_LUT_KEYS_CRYPTOCFG_R16 +
> +					 QCOM_ICE_LUT_KEYS_CRYPTOCFG_OFFSET * slot);
> +
> +	return err;
> +}
> +
>  int qcom_ice_program_key(struct qcom_ice *ice,
>  			 u8 algorithm_id, u8 key_size,
>  			 const struct blk_crypto_key *bkey,
> @@ -288,24 +347,39 @@ int qcom_ice_program_key(struct qcom_ice *ice,
>  
>  	/* Only AES-256-XTS has been tested so far. */
>  	if (algorithm_id != QCOM_ICE_CRYPTO_ALG_AES_XTS ||
> -	    key_size != QCOM_ICE_CRYPTO_KEY_SIZE_256) {
> +	    (key_size != QCOM_ICE_CRYPTO_KEY_SIZE_256 &&
> +	    key_size != QCOM_ICE_CRYPTO_KEY_SIZE_WRAPPED)) {
>  		dev_err_ratelimited(dev,
>  				    "Unhandled crypto capability; algorithm_id=%d, key_size=%d\n",
>  				    algorithm_id, key_size);
>  		return -EINVAL;
>  	}
>  
> -	memcpy(key.bytes, bkey->raw, AES_256_XTS_KEY_SIZE);
> -
> -	/* The SCM call requires that the key words are encoded in big endian */
> -	for (i = 0; i < ARRAY_SIZE(key.words); i++)
> -		__cpu_to_be32s(&key.words[i]);
> +	if (bkey->crypto_cfg.key_type == BLK_CRYPTO_KEY_TYPE_HW_WRAPPED) {
> +		/* It is expected that HWKM init has completed before programming wrapped keys */
> +		if (!ice->use_hwkm || !ice->hwkm_init_complete) {
> +			dev_err_ratelimited(dev, "HWKM not currently used or initialized\n");
> +			return -EINVAL;
> +		}
> +		err = qcom_ice_program_wrapped_key(ice, bkey, data_unit_size,
> +						   slot);
> +	} else {
> +		if (bkey->size != QCOM_ICE_CRYPTO_KEY_SIZE_256)
> +			dev_err_ratelimited(dev,
> +					    "Incorrect key size; bkey->size=%d\n",
> +					    algorithm_id);
> +		return -EINVAL;
> +		memcpy(key.bytes, bkey->raw, AES_256_XTS_KEY_SIZE);
>  
> -	err = qcom_scm_ice_set_key(slot, key.bytes, AES_256_XTS_KEY_SIZE,
> -				   QCOM_SCM_ICE_CIPHER_AES_256_XTS,
> -				   data_unit_size);
> +		/* The SCM call requires that the key words are encoded in big endian */
> +		for (i = 0; i < ARRAY_SIZE(key.words); i++)
> +			__cpu_to_be32s(&key.words[i]);
>  
> -	memzero_explicit(&key, sizeof(key));
> +		err = qcom_scm_ice_set_key(slot, key.bytes, AES_256_XTS_KEY_SIZE,
> +					   QCOM_SCM_ICE_CIPHER_AES_256_XTS,
> +					   data_unit_size);
> +		memzero_explicit(&key, sizeof(key));
> +	}
>  
>  	return err;
>  }
> @@ -313,7 +387,21 @@ EXPORT_SYMBOL_GPL(qcom_ice_program_key);
>  
>  int qcom_ice_evict_key(struct qcom_ice *ice, int slot)
>  {
> -	return qcom_scm_ice_invalidate_key(slot);
> +	int hwkm_slot = slot;
> +
> +	if (ice->use_hwkm) {
> +		hwkm_slot = translate_hwkm_slot(ice, slot);
> +	/*
> +	 * Ignore calls to evict key when HWKM is supported and hwkm init
> +	 * is not yet done. This is to avoid the clearing all slots call
> +	 * during a storage reset when ICE is still in legacy mode. HWKM slave
> +	 * in ICE takes care of zeroing out the keytable on reset.
> +	 */
> +		if (!ice->hwkm_init_complete)
> +			return 0;
> +	}
> +
> +	return qcom_scm_ice_invalidate_key(hwkm_slot);
>  }
>  EXPORT_SYMBOL_GPL(qcom_ice_evict_key);
>  
> @@ -323,6 +411,15 @@ bool qcom_ice_hwkm_supported(struct qcom_ice *ice)
>  }
>  EXPORT_SYMBOL_GPL(qcom_ice_hwkm_supported);
>  
> +int qcom_ice_derive_sw_secret(struct qcom_ice *ice, const u8 wkey[],
> +			      unsigned int wkey_size,
> +			      u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE])
> +{
> +	return qcom_scm_derive_sw_secret(wkey, wkey_size,
> +					 sw_secret, BLK_CRYPTO_SW_SECRET_SIZE);
> +}
> +EXPORT_SYMBOL_GPL(qcom_ice_derive_sw_secret);
> +
>  static struct qcom_ice *qcom_ice_create(struct device *dev,
>  					void __iomem *base)
>  {
> diff --git a/include/soc/qcom/ice.h b/include/soc/qcom/ice.h
> index 1f52e82e3e1c..dabe0d3a1fd0 100644
> --- a/include/soc/qcom/ice.h
> +++ b/include/soc/qcom/ice.h
> @@ -17,6 +17,7 @@ enum qcom_ice_crypto_key_size {
>  	QCOM_ICE_CRYPTO_KEY_SIZE_192		= 0x2,
>  	QCOM_ICE_CRYPTO_KEY_SIZE_256		= 0x3,
>  	QCOM_ICE_CRYPTO_KEY_SIZE_512		= 0x4,
> +	QCOM_ICE_CRYPTO_KEY_SIZE_WRAPPED	= 0x5,
>  };
>  
>  enum qcom_ice_crypto_alg {
> @@ -35,5 +36,8 @@ int qcom_ice_program_key(struct qcom_ice *ice,
>  			 u8 data_unit_size, int slot);
>  int qcom_ice_evict_key(struct qcom_ice *ice, int slot);
>  bool qcom_ice_hwkm_supported(struct qcom_ice *ice);
> +int qcom_ice_derive_sw_secret(struct qcom_ice *ice, const u8 wkey[],
> +			      unsigned int wkey_size,
> +			      u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE]);
>  struct qcom_ice *of_qcom_ice_get(struct device *dev);
>  #endif /* __QCOM_ICE_H__ */
> -- 
> 2.43.0

