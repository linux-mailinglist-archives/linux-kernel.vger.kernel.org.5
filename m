Return-Path: <linux-kernel+bounces-52873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A21849DAE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F3F1F248DC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D102C6B2;
	Mon,  5 Feb 2024 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QnjGB+0Z"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E102C68C
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707145719; cv=none; b=hWbZ2278dxFU84DBNND4OpYgJVovQQ1RFKCvNW4jDoQ1y2Khv1oCZklBVuimAZr40StV4VABX5y20g6PU/O9K/hqltEYvunv+FEJhrM45TFjUrc5jGBYjz6ZIJsF8e9ZG3yA+vI3eRfOTqKak1j9vfEMGuKUOvhWPHidN4icUCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707145719; c=relaxed/simple;
	bh=wvaEJWBBf8XXgbtllbzrWQ+8i6hI9AAF2jUuyLOO7wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZ6sa5pZTgKBS3zEv0QTIJx8oKgnlekis3mf2NoKHZYyMRihWlhYOmQ74/90jVNzLqcF9JdEWyrqBu8s/5Dv60Z0BTegKz8OoTTQ0WnVfu1joj7kp059bgh7Wd2kuPRyJ/cHLq8v6pvvSYh1JNzqHr6YxJ1t9uP1yAYIAyf4pFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QnjGB+0Z; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60412f65124so41716947b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 07:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707145715; x=1707750515; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BVyjF8W3YVWuSuA8Z2O+D42mw+vpiZTpLdVWYHZ9Exo=;
        b=QnjGB+0Z5altQrq89HIwGYShD4UeEb2ggdNd/YoPM0SErEc54HAg1ISJPjXGwZ78gt
         a97v9MpWRwSoWNtU3/kmaI5D8/BUs3FvmE/mVg9CHOcU0vZJAoMLIsfqo/b3fz/fGibk
         V7K14bDqb0iPB0c1SvjYYEQk+iuZh9VJHAEC/uhdMxotUUCRKhal1Ip/uQiL+REIjaSE
         epsZqq/3aMKHpJEybh9hchVJF8MxzjEvwVqY6gXpN/KVC3ReZqPsdgyDgDJdpF49o3NN
         C03Soi5ul8BEx6XeNikyeRn6cZ32toqQKLOCxik6QAjkbtoiLK4mXCdkMdJVaCwFbu2Y
         Ew9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707145715; x=1707750515;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BVyjF8W3YVWuSuA8Z2O+D42mw+vpiZTpLdVWYHZ9Exo=;
        b=xH2nVtP6ocdKFH+skuv7BdEMaBIxaMPx9XuiqVQ4ArV9ez4GT1qJUXBxk/MjJDnaTD
         IjoZIod7FNf+CE4CfIF+kicQGGYzqg+vXUR1f5z921C4Q3gBu/QuLGbb1pz7cHC6DSSq
         IxAn6K1x8lQEikCtwC3MsRFo+5jaQpgqoY/iYPOzcwcJ17iSN7kO4a2DYP2BEQ78ZnBZ
         aJ7XIrvOBWB1o1PpVjpXMkPD5GeMv1O/gPw99T0yf2E6mnRhK0Y8uxy/c+MMvGqJ9LRR
         5HNVK7VvnittWXxhhfZBzTucc1nGJoB+hlO5FO8PoP26/s+ONb44imxNR+uyeAOMwkyh
         4p7w==
X-Gm-Message-State: AOJu0Yx39lTa2O5Lt4Q77Dd/BuoTuEIbg7t2CSmLdV4aDwLTcEoWO3hI
	/4k7fAayzFVXd8UhbTx5552BVGZxr0OjUEKOFuCAK4TK1LnvoO/YDp9EqR5eeOTquHh9ogh2O66
	niGIWK0CQGqfnYKmdKQXu3PStk8vg2+6XiYgbUQ==
X-Google-Smtp-Source: AGHT+IEbPEF+M2N5CaM8t5MnLmTWiPiKAvGtlfcV/lkpNMjenlQekFQraeVbM1SlJsJ5MOISqXBVaXmZnC4U1Gk17So=
X-Received: by 2002:a81:4f03:0:b0:5ff:958d:5b2 with SMTP id
 d3-20020a814f03000000b005ff958d05b2mr8439655ywb.51.1707145715558; Mon, 05 Feb
 2024 07:08:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205145606.16936-1-quic_okukatla@quicinc.com> <20240205145606.16936-2-quic_okukatla@quicinc.com>
In-Reply-To: <20240205145606.16936-2-quic_okukatla@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 5 Feb 2024 17:08:24 +0200
Message-ID: <CAA8EJprAfJJKQKKa8qODdP2xiYo53jPN-1j+2jKKQyWTnH8vmQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] interconnect: qcom: icc-rpmh: Add QoS
 configuration support
To: Odelu Kukatla <quic_okukatla@quicinc.com>
Cc: djakov@kernel.org, rafael@kernel.org, corbet@lwn.net, 
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_viveka@quicinc.com, peterz@infradead.org, 
	quic_mdtipton@quicinc.com, linux-arm-msm@vger.kernel.org, 
	konrad.dybcio@linaro.org, krzysztof.kozlowski@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Feb 2024 at 16:57, Odelu Kukatla <quic_okukatla@quicinc.com> wrote:
>
> It adds QoS support for QNOC device and includes support for
> configuring priority, priority forward disable, urgency forwarding.
> This helps in priortizing the traffic originating from different
> interconnect masters at NoC(Network On Chip).
>
> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
> ---
>  drivers/interconnect/qcom/icc-rpmh.c | 161 ++++++++++++++++++++++++++-
>  drivers/interconnect/qcom/icc-rpmh.h |  32 ++++++
>  2 files changed, 189 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
> index c1aa265c1f4e..67e600f1191d 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.c
> +++ b/drivers/interconnect/qcom/icc-rpmh.c
> @@ -1,28 +1,69 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>
> +#include <linux/clk.h>
>  #include <linux/interconnect.h>
>  #include <linux/interconnect-provider.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/slab.h>
> +#include <linux/bits.h>
>
>  #include "bcm-voter.h"
>  #include "icc-common.h"
>  #include "icc-rpmh.h"
>
> +/* QNOC QoS */
> +#define QOSGEN_MAINCTL_LO(p, qp)       (0x8 + (p->port_offsets[qp]))
> +#define QOS_SLV_URG_MSG_EN_MASK                BIT_MASK(3)
> +#define QOS_DFLT_PRIO_MASK             GENMASK(6, 4)
> +#define QOS_DISABLE_MASK               BIT_MASK(24)
> +
> +/**
> + * qcom_icc_set_qos - initialize static QoS configurations
> + * @qp: qcom icc provider to which @node belongs
> + * @node: qcom icc node to operate on
> + */
> +static void qcom_icc_set_qos(struct qcom_icc_provider *qp,
> +                               struct qcom_icc_node *node)
> +{
> +       const struct qcom_icc_qosbox *qos = node->qosbox;
> +       int port;
> +
> +       if (!qp->regmap)
> +               return;
> +
> +       if (!qos)
> +               return;
> +
> +       for (port = 0; port < qos->num_ports; port++) {
> +               regmap_update_bits(qp->regmap, QOSGEN_MAINCTL_LO(qos, port),
> +                                  QOS_DISABLE_MASK,
> +                                  FIELD_PREP(QOS_DISABLE_MASK, qos->prio_fwd_disable));
> +
> +               regmap_update_bits(qp->regmap, QOSGEN_MAINCTL_LO(qos, port),
> +                                  QOS_DFLT_PRIO_MASK,
> +                                  FIELD_PREP(QOS_DFLT_PRIO_MASK, qos->prio));
> +
> +               regmap_update_bits(qp->regmap, QOSGEN_MAINCTL_LO(qos, port),
> +                                  QOS_SLV_URG_MSG_EN_MASK,
> +                                  FIELD_PREP(QOS_SLV_URG_MSG_EN_MASK, qos->urg_fwd));
> +       }
> +}
> +
>  /**
>   * qcom_icc_pre_aggregate - cleans up stale values from prior icc_set
>   * @node: icc node to operate on
>   */
>  void qcom_icc_pre_aggregate(struct icc_node *node)
>  {
> -       size_t i;
> -       struct qcom_icc_node *qn;
>         struct qcom_icc_provider *qp;
> +       struct qcom_icc_node *qn;
> +       size_t i;
>
>         qn = node->data;
>         qp = to_qcom_provider(node->provider);
> @@ -49,8 +90,8 @@ EXPORT_SYMBOL_GPL(qcom_icc_pre_aggregate);
>  int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
>                        u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
>  {
> -       size_t i;
>         struct qcom_icc_node *qn;
> +       size_t i;

Please abstain from making the cleanup changes in the same patch as
the functional changes. These changes either should be dropped or
moved to a separate patch.

>
>         qn = node->data;
>
> @@ -159,13 +200,96 @@ int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(qcom_icc_bcm_init);
>
> +static bool bcm_needs_qos_proxy(struct qcom_icc_bcm *bcm)

Although this part is not exported to the modules, I think it deserves
some documentation. Either in the commit message or in the source
file.

> +{
> +       int i;
> +
> +       for (i = 0; i < bcm->num_nodes; i++)
> +               if (bcm->nodes[i]->qosbox)
> +                       return true;
> +
> +       return false;
> +}
> +
> +static int enable_qos_deps(struct qcom_icc_provider *qp)
> +{
> +       struct qcom_icc_bcm *bcm;
> +       bool keepalive;
> +       int ret, i;
> +
> +       for (i = 0; i < qp->num_bcms; i++) {
> +               bcm = qp->bcms[i];
> +               if (bcm_needs_qos_proxy(bcm)) {
> +                       keepalive = bcm->keepalive;
> +                       bcm->keepalive = true;
> +
> +                       qcom_icc_bcm_voter_add(qp->voter, bcm);
> +                       ret = qcom_icc_bcm_voter_commit(qp->voter);
> +
> +                       bcm->keepalive = keepalive;
> +
> +                       if (ret) {
> +                               dev_err(qp->dev, "failed to vote BW to %s for QoS\n",
> +                                       bcm->name);
> +                               return ret;
> +                       }
> +               }
> +       }
> +
> +       ret = clk_bulk_prepare_enable(qp->num_clks, qp->clks);
> +       if (ret)
> +               dev_err(qp->dev, "failed to enable clocks for QoS\n");
> +
> +       return ret;
> +}
> +
> +static void disable_qos_deps(struct qcom_icc_provider *qp)
> +{
> +       struct qcom_icc_bcm *bcm;
> +       int i;
> +
> +       clk_bulk_disable_unprepare(qp->num_clks, qp->clks);
> +
> +       for (i = 0; i < qp->num_bcms; i++) {
> +               bcm = qp->bcms[i];
> +               if (bcm_needs_qos_proxy(bcm)) {
> +                       qcom_icc_bcm_voter_add(qp->voter, bcm);
> +                       qcom_icc_bcm_voter_commit(qp->voter);
> +               }
> +       }
> +}
> +
> +static int qcom_icc_rpmh_configure_qos(struct qcom_icc_provider *qp)
> +{
> +       struct qcom_icc_node *qnode;
> +       size_t i;
> +       int ret;
> +
> +       ret = enable_qos_deps(qp);
> +       if (ret)
> +               return ret;
> +
> +       for (i = 0; i < qp->num_nodes; i++) {
> +               qnode = qp->nodes[i];
> +               if (!qnode)
> +                       continue;
> +
> +               if (qnode->qosbox)
> +                       qcom_icc_set_qos(qp, qnode);
> +       }
> +
> +       disable_qos_deps(qp);
> +
> +       return ret;
> +}
> +
>  int qcom_icc_rpmh_probe(struct platform_device *pdev)
>  {
> +       struct qcom_icc_node * const *qnodes, *qn;
>         const struct qcom_icc_desc *desc;
>         struct device *dev = &pdev->dev;
>         struct icc_onecell_data *data;
>         struct icc_provider *provider;
> -       struct qcom_icc_node * const *qnodes, *qn;
>         struct qcom_icc_provider *qp;
>         struct icc_node *node;
>         size_t num_nodes, i, j;
> @@ -199,12 +323,35 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
>
>         qp->dev = dev;
>         qp->bcms = desc->bcms;
> +       qp->nodes = desc->nodes;
>         qp->num_bcms = desc->num_bcms;
> +       qp->num_nodes = desc->num_nodes;
>
>         qp->voter = of_bcm_voter_get(qp->dev, NULL);
>         if (IS_ERR(qp->voter))
>                 return PTR_ERR(qp->voter);
>
> +       if (desc->config) {
> +               struct resource *res;
> +               void __iomem *base;
> +
> +               res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +               if (!res)
> +                       return -ENODEV;

Having a working ICC even without QoS changes is still important. I'd
suggest to warn the user here and continue probe, skipping QoS
settings.

> +
> +               base = devm_ioremap(dev, res->start, resource_size(res));
> +               if (IS_ERR(base))
> +                       return PTR_ERR(base);
> +
> +               qp->regmap = devm_regmap_init_mmio(dev, base, desc->config);
> +               if (IS_ERR(qp->regmap))
> +                       return PTR_ERR(qp->regmap);
> +       }
> +
> +       qp->num_clks = devm_clk_bulk_get_all(qp->dev, &qp->clks);
> +       if (qp->num_clks < 0)
> +               return qp->num_clks;
> +
>         for (i = 0; i < qp->num_bcms; i++)
>                 qcom_icc_bcm_init(qp->bcms[i], dev);
>
> @@ -229,6 +376,10 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
>                 data->nodes[i] = node;
>         }
>
> +       ret = qcom_icc_rpmh_configure_qos(qp);
> +       if (ret)
> +               goto err_remove_nodes;
> +
>         ret = icc_provider_register(provider);
>         if (ret)
>                 goto err_remove_nodes;
> @@ -247,6 +398,7 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
>  err_deregister_provider:
>         icc_provider_deregister(provider);
>  err_remove_nodes:
> +       clk_bulk_put_all(qp->num_clks, qp->clks);

No!!! You should never manually free the resources that are handled by
the devm_ functions. In rare cases it is really necessary for some
reason, there exists a counterpart devm_free_something funciton.

>         icc_nodes_remove(provider);
>
>         return ret;
> @@ -258,6 +410,7 @@ void qcom_icc_rpmh_remove(struct platform_device *pdev)
>         struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
>
>         icc_provider_deregister(&qp->provider);
> +       clk_bulk_put_all(qp->num_clks, qp->clks);

And here again.

>         icc_nodes_remove(&qp->provider);
>  }
>  EXPORT_SYMBOL_GPL(qcom_icc_rpmh_remove);
> diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
> index 2de29460e808..65cef156f212 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.h
> +++ b/drivers/interconnect/qcom/icc-rpmh.h
> @@ -1,12 +1,14 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>
>  #ifndef __DRIVERS_INTERCONNECT_QCOM_ICC_RPMH_H__
>  #define __DRIVERS_INTERCONNECT_QCOM_ICC_RPMH_H__
>
>  #include <dt-bindings/interconnect/qcom,icc.h>
> +#include <linux/regmap.h>
>
>  #define to_qcom_provider(_provider) \
>         container_of(_provider, struct qcom_icc_provider, provider)
> @@ -18,6 +20,11 @@
>   * @bcms: list of bcms that maps to the provider
>   * @num_bcms: number of @bcms
>   * @voter: bcm voter targeted by this provider
> + * @nodes: list of icc nodes that maps to the provider
> + * @num_nodes: number of @nodes
> + * @regmap: used for QoS, register access
> + * @clks : clks required for register access
> + * @num_clks: number of @clks
>   */
>  struct qcom_icc_provider {
>         struct icc_provider provider;
> @@ -25,6 +32,11 @@ struct qcom_icc_provider {
>         struct qcom_icc_bcm * const *bcms;
>         size_t num_bcms;
>         struct bcm_voter *voter;
> +       struct qcom_icc_node * const *nodes;
> +       size_t num_nodes;
> +       struct regmap *regmap;
> +       struct clk_bulk_data *clks;
> +       int num_clks;

Is it really necessary to store this in the global data? If I
understand correctly, QoS is only programmed during the boot and is
not to be reprogrammed later. Is my understanding correct?

>  };
>
>  /**
> @@ -41,6 +53,23 @@ struct bcm_db {
>         u8 reserved;
>  };
>
> +/**
> + * struct qcom_icc_qosbox - Qualcomm specific QoS config

Why is it qosbox?

> + * @prio: priority value assigned to requests on the node
> + * @urg_fwd: if set, master priority is used for requests.
> + * @prio_fwd_disable: if set, master priority is ignored and NoC's default priority is used.
> + * @num_ports: number of @ports
> + * @port_offsets: qos register offsets
> + */
> +
> +struct qcom_icc_qosbox {
> +       const u32 prio;
> +       const bool urg_fwd;
> +       const bool prio_fwd_disable;
> +       const u32 num_ports;
> +       const u32 port_offsets[] __counted_by(num_ports);
> +};
> +
>  #define MAX_LINKS              128
>  #define MAX_BCMS               64
>  #define MAX_BCM_PER_NODE       3
> @@ -58,6 +87,7 @@ struct bcm_db {
>   * @max_peak: current max aggregate value of all peak bw requests
>   * @bcms: list of bcms associated with this logical node
>   * @num_bcms: num of @bcms
> + * @qosbox: qos config data associated with node
>   */
>  struct qcom_icc_node {
>         const char *name;
> @@ -70,6 +100,7 @@ struct qcom_icc_node {
>         u64 max_peak[QCOM_ICC_NUM_BUCKETS];
>         struct qcom_icc_bcm *bcms[MAX_BCM_PER_NODE];
>         size_t num_bcms;
> +       const struct qcom_icc_qosbox *qosbox;
>  };
>
>  /**
> @@ -114,6 +145,7 @@ struct qcom_icc_fabric {
>  };
>
>  struct qcom_icc_desc {
> +       const struct regmap_config *config;
>         struct qcom_icc_node * const *nodes;
>         size_t num_nodes;
>         struct qcom_icc_bcm * const *bcms;
> --
> 2.17.1
>
>


-- 
With best wishes
Dmitry

