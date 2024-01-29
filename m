Return-Path: <linux-kernel+bounces-43161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81275840C9B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7BCAB24D14
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159E6157038;
	Mon, 29 Jan 2024 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O/z872tb"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1E1155A5F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547485; cv=none; b=g+4QpvkJGurgYCw+Jvvf2EwyaAEgC6Yt/4PQ9rLjp1UKEdiGOWT29egmOAF/kQQJobWcdpBjHIEfFvRv+7Z8TU0OwVUS1Rip7zxDRK0ngIGvHzvnBF+tg4YvQqYRsHgthLz39uampRR+OdTEMzrmH6jp/X5I3PKmHfsVw4FVXbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547485; c=relaxed/simple;
	bh=H7yE0TLn19iCiWHo/FkB1Rzc6lLBWxGxr0DrrmYLh3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cY8lLoWuU6+LuH9tTSzMv213t8xdw2BvkZdgmAdKB1j8HUJ+N1VobeDjU3OFZuAeTjhSkUECNHbZ8g3nAi9UuYFbEEL0C7QGxXw1jc7p0u8gufCmsWH3mjCDbxmI+NDmbQOiARRIsjLRNLTwP7qskMDCjcb+P8QTKIaZCfwopNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O/z872tb; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55eda7c5bffso12524a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 08:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706547481; x=1707152281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/syXXY1Bnocb0Cr84guiLCcezGMcnPfVVnMLYh6D2Q=;
        b=O/z872tbAJ5o/TS4F5Cd5pqyyH25Yzjz9fXBdRocYWJ4SQpp00v6CO6tc0jke/xYHM
         2D0RJ20lDLtIBv2c5MXVupAzzfN+f75C4HawN6pcTI5zdJiruzq0awNNXAyu22uDC5VP
         BAGA7nRoTyHh2kJs837ya/w+KvECxKFRJkrJzwkdv+HS57XmJC94+xBRw3+pXP1lqD9N
         t88yl5Wj8P+tcLITdkcH27vbhKihFA27aWTXzXs4f1BZ5Fjb8Lg8mJGUzhN+ouHEcf5L
         UyOoxXWTrgvk/IJIEvrz6xq5dQWJ2mDPIpRYBvVQWG+jddM6/ZIqX6UFPTDgfZXyLHuQ
         QfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706547481; x=1707152281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/syXXY1Bnocb0Cr84guiLCcezGMcnPfVVnMLYh6D2Q=;
        b=kOn7wMnUe6/GgQHsC7DMatATbNfGULnXy7SQoFEyHBdy/cAcckAodKUH1aNAgsuL9w
         +utEN1U+5rmRT3x0R+p/CoF28UCZlckyh8fQy39/2TXcqRx/fz+xuLuU0Am72LRcMlNl
         Iv3gBc4AIlmA78N4Q3xiC99GZ3LWfL5xUpZhV2bUsN0f5ZDCBgy4PwFmNKgKLFgmMokc
         yWoLY8a183TmsC86RAGJWobNIBseOTVyUngUQraNUtGFj4oog6OXSkrymoUUMyR/jioc
         2t9ui25YxQ04Zum+thY5I+F+hU9kquWDDyeG6lRZxarMtrL32ABE0MoPouUgRLIZug6F
         uLNA==
X-Gm-Message-State: AOJu0Yw4q7T7VDS6X7mwYW0YMEkcplMqQq7uu7FAqvNKd4aqsNy4mOOO
	SMSA7rI5q6zoHhKsHtPofSKRADGrryArG2dhyPhS+wXWCmA3SG1+VolM+QUQPf6JA3Nr9UK1YDd
	OGt43Z1kn47pQRImd/dkoJTn2t7/YmDHM85jr
X-Google-Smtp-Source: AGHT+IFwTYFTgvHTNZp2/70im1mOgO6bOgpZmgF7iH0m3dzPzmHnHcy1zYSsfZIjKRWt8jUXXH2+uz7tsRTLyh1ayNQ=
X-Received: by 2002:a05:6402:3115:b0:55f:1351:ee28 with SMTP id
 dc21-20020a056402311500b0055f1351ee28mr147467edb.6.1706547481247; Mon, 29 Jan
 2024 08:58:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240128212532.2754325-1-sameo@rivosinc.com> <20240128212532.2754325-2-sameo@rivosinc.com>
In-Reply-To: <20240128212532.2754325-2-sameo@rivosinc.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Mon, 29 Jan 2024 08:57:49 -0800
Message-ID: <CAAH4kHaToau86TiYFmLqVKETomYSUmb=d4OjXSKi03C6HWYAQw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] tsm: Runtime measurement register support
To: Samuel Ortiz <sameo@rivosinc.com>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Qinkun Bao <qinkun@google.com>, 
	"Yao, Jiewen" <jiewen.yao@intel.com>, "Xing, Cedric" <cedric.xing@intel.com>, biao.lu@intel.com, 
	linux-coco@lists.linux.dev, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The rtmr backend doesn't specify the digest size it expects to user
space, so rtmr_extend could be zero-fill, or provide a truncated
update, or be strict and return an error. Should the expected digest
size for writes not also be a RO attribute?

On Sun, Jan 28, 2024 at 1:27=E2=80=AFPM Samuel Ortiz <sameo@rivosinc.com> w=
rote:
>
> Some confidential computing architecture (Intel TDX, ARM-CCA, RISC-V
> CoVE) provide the TVM (confidential computing guest) with a set of
> runtime measurement registers (RTMR). TVMs can extend those registers
> with their measurements at runtime, i.e. after the TVM initial
> measurements are finalized and the TVM actually runs.
>
> RTMRs are separated from the initial measurement registers set, and TSMs
> typically includes RTMR values into a distinct section of their signed
> attestion reports.
>
> We add support for extending and reading a TSM runtime measurement
> registers by extending the TSM ops structure with resp. an rtmr_extend()
> and an rtmr_read() function pointers. TSM providers/backends will
> implement those ops if they are capable of exposing RTMRs to their
> TVMs. This capability is now described by a tsm_capabilites structure,
> passed by the TSM provider to the TSM framework at registration time.
>
> TVMs can configure, extend and read RTMRs from the configfs-tsm interface=
.
>
> Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
> ---
>  drivers/virt/coco/tsm.c | 80 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/tsm.h     | 39 +++++++++++++++++++-
>  2 files changed, 118 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
> index d1c2db83a8ca..1a8c3c096120 100644
> --- a/drivers/virt/coco/tsm.c
> +++ b/drivers/virt/coco/tsm.c
> @@ -11,6 +11,7 @@
>  #include <linux/module.h>
>  #include <linux/cleanup.h>
>  #include <linux/configfs.h>
> +#include <linux/tpm.h>
>
>  static struct tsm_provider {
>         const struct tsm_ops *ops;
> @@ -50,6 +51,85 @@ enum tsm_data_select {
>         TSM_CERTS,
>  };
>
> +/**
> + * DOC: Trusted Security Module (TSM) Runtime Measurement Register (RTMR=
) Interface
> + *
> + * The TSM RTMR interface is a common ABI for allowing TVMs to extend
> + * and read measurement registers at runtime, i.e. after the TVM initial
> + * measurement is finalized. TSMs that support such capability will typi=
cally
> + * include all runtime measurement registers values into their signed
> + * attestation report, providing the TVM post-boot measurements to e.g. =
remote
> + * attestation services.
> + *
> + * A TVM uses the TSM RTMR configfs ABI to create all runtime measuremen=
t
> + * registers (RTMR) that it needs. Each created RTMR must be configured =
first
> + * before being readable and extensible. TVM configures an RTMR by setti=
ng its
> + * index and optionally by mapping it to one or more TCG PCR indexes.
> + *
> + * A TSM backend statically declares the number of RTMRs it supports and=
 which
> + * hash algorithm must be used when extending them. This declaration is =
done
> + * through the tsm_capabilities structure, at TSM registration time (see
> + * tsm_register()).
> + */
> +
> +/**
> + * struct tsm_rtmr_state - tracks the state of a TSM RTMR.
> + * @index: The RTMR hardware index.
> + * @alg: The hash algorithm used for this RTMR.
> + * @digest: The RTMR cached digest value.
> + * @cached_digest: Is the RTMR cached digest valid or not.
> + * @cfg: The configfs item for this RTMR.
> + */
> +struct tsm_rtmr_state {
> +       u32 index;
> +       enum hash_algo alg;
> +       u8 digest[TSM_DIGEST_MAX];
> +       bool cached_digest;
> +       struct config_item cfg;
> +};
> +
> +static bool is_rtmr_configured(struct tsm_rtmr_state *rtmr_state)
> +{
> +       return rtmr_state->index !=3D U32_MAX;
> +}
> +
> +/**
> + * struct tsm_rtmrs_state - tracks the state of all RTMRs for a TSM.
> + * @rtmrs: The array of all created RTMRs.
> + * @tcg_map: A mapping between TCG PCR and RTMRs, indexed by PCR indexes=
.
> + * Entry `i` on this map points to an RTMR that covers TCG PCR[i] for th=
e TSM
> + * hash algorithm.
> + * @group: The configfs group for a TSM RTMRs.
> + */
> +static struct tsm_rtmrs_state {
> +       struct tsm_rtmr_state **rtmrs;
> +       const struct tsm_rtmr_state *tcg_map[TPM2_PLATFORM_PCR];
> +       struct config_group *group;
> +} *tsm_rtmrs;
> +
> +static int tsm_rtmr_read(struct tsm_provider *tsm, u32 idx,
> +                        u8 *digest, size_t digest_size)
> +{
> +       if (tsm->ops && tsm->ops->rtmr_read)
> +               return tsm->ops->rtmr_read(idx, digest, digest_size);
> +
> +       return -ENXIO;
> +}
> +
> +static int tsm_rtmr_extend(struct tsm_provider *tsm, u32 idx,
> +                          const u8 *digest, size_t digest_size)
> +{
> +       if (tsm->ops && tsm->ops->rtmr_extend)
> +               return tsm->ops->rtmr_extend(idx, digest, digest_size);
> +
> +       return -ENXIO;
> +}
> +
> +static struct tsm_rtmr_state *to_tsm_rtmr_state(struct config_item *cfg)
> +{
> +       return container_of(cfg, struct tsm_rtmr_state, cfg);
> +}
> +
>  static struct tsm_report *to_tsm_report(struct config_item *cfg)
>  {
>         struct tsm_report_state *state =3D
> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> index de8324a2223c..a546983c24fc 100644
> --- a/include/linux/tsm.h
> +++ b/include/linux/tsm.h
> @@ -2,11 +2,13 @@
>  #ifndef __TSM_H
>  #define __TSM_H
>
> +#include <crypto/hash_info.h>
>  #include <linux/sizes.h>
>  #include <linux/types.h>
>
>  #define TSM_INBLOB_MAX 64
>  #define TSM_OUTBLOB_MAX SZ_32K
> +#define TSM_DIGEST_MAX SHA512_DIGEST_SIZE
>
>  /*
>   * Privilege level is a nested permission concept to allow confidential
> @@ -42,12 +44,44 @@ struct tsm_report {
>         u8 *auxblob;
>  };
>
> +#define TSM_MAX_RTMR 32
> +
> +/**
> + * struct tsm_rtmr_desc - Describes a TSM Runtime Measurement Register (=
RTMR).
> + * @hash_alg: The hash algorithm used to extend this runtime measurement
> + *            register.
> + * @tcg_pcr_mask: A bit mask of all TCG PCRs mapped to this RTMR.
> + */
> +struct tsm_rtmr_desc {
> +       enum hash_algo hash_alg;
> +       unsigned long tcg_pcr_mask;
> +};
> +
> +/**
> + * struct tsm_capabilities - Describes a TSM capabilities.
> + * @num_rtmrs: The number of Runtime Measurement Registers (RTMR) availa=
ble from
> + *             a TSM.
> + * @rtmr_hash_alg: The hash algorithm used to extend a runtime measureme=
nt
> + *                 register.
> + */
> +struct tsm_capabilities {
> +       size_t num_rtmrs;
> +       const struct tsm_rtmr_desc *rtmrs;
> +};
> +
>  /**
>   * struct tsm_ops - attributes and operations for tsm instances
>   * @name: tsm id reflected in /sys/kernel/config/tsm/report/$report/prov=
ider
>   * @privlevel_floor: convey base privlevel for nested scenarios
> + * @capabilities: Describe the TSM capabilities, e.g. the number of avai=
lable
> + *                runtime measurement registers (see `struct tsm_capabil=
ities`).
>   * @report_new: Populate @report with the report blob and auxblob
> - * (optional), return 0 on successful population, or -errno otherwise
> + *              (optional), return 0 on successful population, or -errno
> + *              otherwise
> + * @rtmr_extend: Extend an RTMR with the provided digest.
> + *               Return 0 on successful extension, or -errno otherwise.
> + * @rtmr_read: Reads the value of an RTMR.
> + *             Return the number of bytes read or -errno for errors.
>   *
>   * Implementation specific ops, only one is expected to be registered at
>   * a time i.e. only one of "sev-guest", "tdx-guest", etc.
> @@ -55,7 +89,10 @@ struct tsm_report {
>  struct tsm_ops {
>         const char *name;
>         const unsigned int privlevel_floor;
> +       const struct tsm_capabilities capabilities;
>         int (*report_new)(struct tsm_report *report, void *data);
> +       int (*rtmr_extend)(u32 idx, const u8 *digest, size_t digest_size)=
;
> +       ssize_t (*rtmr_read)(u32 idx, u8 *digest, size_t digest_size);
>  };
>
>  extern const struct config_item_type tsm_report_default_type;
> --
> 2.42.0
>


--=20
-Dionna Glaze, PhD (she/her)

