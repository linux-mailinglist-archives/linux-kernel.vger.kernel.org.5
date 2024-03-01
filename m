Return-Path: <linux-kernel+bounces-88549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D879186E344
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC26284A4B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D7C6F513;
	Fri,  1 Mar 2024 14:24:50 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A7A6F09C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709303089; cv=none; b=HM7aOBLTYR6hvp+SkyASymuao/uZb6ZnGTHZHMl/pS5Bklb151suhX6E/cR/SMLxRpef/v8uOGieT+u6OxK9V3x/gm4Fbj6+fS3V423UbivDOLRwPzVW1px81OLrHTjjd7jdhPW6uS34c9xPjsGJpUSVSqn95n8SI6kCXCB58mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709303089; c=relaxed/simple;
	bh=YXLdxOmj/R68Jm/J5RqLWwegKYldmJWogNjWasOi9Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdBXT3+4orlCxIBJHUvkDF88Y+PpZ1PRc9VS3s5P9RhNoO6c7bBXzHVDev2lYztKynbS6xXKyN3zkbYad23Tkp94n5SZaU7tLaD2PT/5bq7ZvbpIdtQF0NDymloMTfxnVxvXGcVqW29D0NcvnZaPmY7LZ7gRZWFAItRvssPuF9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rg3o2-0002YQ-Nr; Fri, 01 Mar 2024 15:24:10 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rg3nz-003nVf-Jc; Fri, 01 Mar 2024 15:24:07 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rg3nz-00F6Pu-1b;
	Fri, 01 Mar 2024 15:24:07 +0100
Date: Fri, 1 Mar 2024 15:24:07 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v5 10/17] net: pse-pd: Add support for PSE PIs
Message-ID: <ZeHlB8DLEqWxBRYH@pengutronix.de>
References: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
 <20240227-feature_poe-v5-10-28f0aa48246d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240227-feature_poe-v5-10-28f0aa48246d@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Kory,

On Tue, Feb 27, 2024 at 03:42:52PM +0100, Kory Maincent wrote:
...

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index fed006cbc185..9124eb3d6492 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c
> @@ -27,38 +27,137 @@ struct pse_control {
>  	struct kref refcnt;
>  };
>  
> -/**
> - * of_pse_zero_xlate - dummy function for controllers with one only control
> - * @pcdev: a pointer to the PSE controller device
> - * @pse_spec: PSE line specifier as found in the device tree
> - *
> - * This static translation function is used by default if of_xlate in
> - * :c:type:`pse_controller_dev` is not set. It is useful for all PSE
> - * controllers with #pse-cells = <0>.
> - */

Please replace documentation

> -static int of_pse_zero_xlate(struct pse_controller_dev *pcdev,
> -			     const struct of_phandle_args *pse_spec)
> +static int of_load_pse_pi_pairsets(struct device_node *node,
> +				   struct pse_pi *pi,
> +				   int npairsets)
>  {
> -	return 0;
> +	struct device_node *pairset_np;
> +	const char *name;
> +	int i, ret;
> +
> +	for (i = 0; i < npairsets; i++) {

please move this scope to a separate function.

> +		ret = of_property_read_string_index(node,
> +						    "pairset-names",
> +						     i, &name);
> +		if (ret)
> +			break;
> +
> +		if (strcmp(name, "alternative-a")) {

strcmp returns 0 if it matching

		if (!strcmp(name, "alternative-a")) {


> +			pi->pairset[i].pinout = ALTERNATIVE_A;
> +		} else if (strcmp(name, "alternative-b")) {

		if (!strcmp(name, "alternative-a")) {

> +			pi->pairset[i].pinout = ALTERNATIVE_B;
> +		} else {
> +			pr_err("pse: wrong pairset-names value %s\n", name);
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		pairset_np = of_parse_phandle(node, "pairsets", i);
> +		if (!pairset_np) {
> +			ret = -ENODEV;
> +			break;
> +		}
> +
> +		pi->pairset[i].np = pairset_np;
> +	}
> +
> +	if (i == 2 && pi->pairset[0].pinout == pi->pairset[1].pinout) {
> +		pr_err("pse: two PI pairsets can not have identical pinout");
> +		ret = -EINVAL;
> +	}
> +
> +	/* If an error appears on the second pairset load, release the first
> +	 * pairset device node kref
> +	 */
> +	if (ret) {
> +		of_node_put(pi->pairset[0].np);
> +		pi->pairset[0].np = NULL;
> +		of_node_put(pi->pairset[1].np);
> +		pi->pairset[1].np = NULL;
> +	}
> +
> +	return ret;
>  }
>  
> -/**
> - * of_pse_simple_xlate - translate pse_spec to the PSE line number
> - * @pcdev: a pointer to the PSE controller device
> - * @pse_spec: PSE line specifier as found in the device tree
> - *
> - * This static translation function is used by default if of_xlate in
> - * :c:type:`pse_controller_dev` is not set. It is useful for all PSE
> - * controllers with 1:1 mapping, where PSE lines can be indexed by number
> - * without gaps.
> - */

Please replace documentation

> -static int of_pse_simple_xlate(struct pse_controller_dev *pcdev,
> -			       const struct of_phandle_args *pse_spec)
> +static int of_load_pse_pis(struct pse_controller_dev *pcdev)
>  {
> -	if (pse_spec->args[0] >= pcdev->nr_lines)
> -		return -EINVAL;
> +	struct device_node *np = pcdev->dev->of_node;
> +	struct device_node *node, *pis;
> +	int ret, i;
>  
> -	return pse_spec->args[0];
> +	if (!np)
> +		return -ENODEV;
> +
> +	pcdev->pi = kcalloc(pcdev->nr_lines, sizeof(*pcdev->pi), GFP_KERNEL);
> +	if (!pcdev->pi)
> +		return -ENOMEM;
> +
> +	pis = of_get_child_by_name(np, "pse-pis");
> +	if (!pis) {

Do we need to allocate pcdev->pi if there are no pse-pis?

> +		/* Legacy OF description of PSE PIs */
> +		pcdev->of_legacy = true;

It is not "legacy" :) PoDL do not providing definition of PSE PI since there
is only one pair. May be: single_pair, no_pse_pi or any other idea.

> +		return 0;
> +	}
> +
> +	for_each_child_of_node(pis, node) {

please move this scope to a separate function.

> +		struct pse_pi pi = {0};
> +		int npairsets;
> +		u32 id;
> +
> +		if (!of_node_name_eq(node, "pse-pi"))
> +			continue;
> +
> +		ret = of_property_read_u32(node, "reg", &id);
> +		if (ret)

error: can't get "reg" property for node "%s"

> +			goto out;
> +
> +		if (id >= pcdev->nr_lines || pcdev->pi[id].np) {

Here two different kind of errors:
- (id >= pcdev->nr_lines) reg value is out of range. print value and max
  range.
- (pcdev->pi[id].np) other node with same reg value was already
  registered... print both node names.

> +			dev_err(pcdev->dev, "wrong id of pse pi: %u\n",
> +				id);
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
> +		ret = of_property_count_strings(node, "pairset-names");
> +		if (ret <= 0)

if (ret < 0)
   error: can't get "pairset-names" property: %pe
if (ret < 1 || ret > 2)
   error: wrong number of pairset-names. Should be 1 or 2, got %i

> +			goto out;
> +		npairsets = ret;
> +
> +		ret = of_count_phandle_with_args(node, "pairsets", NULL);
> +		if (ret <= 0)

same as for pairset-names

> +			goto out;
> +
> +		/* npairsets is limited to value one or two */
> +		if (ret != npairsets || ret > 2) {

(ret > 2) will be handled by previous checks
(ret != npairsets) amount of pairsets and pairset-names is not equal %i
!= %i

> +			dev_err(pcdev->dev,
> +				"wrong number of pairsets or pairset-names for pse pi %d\n",
> +				id);
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
> +		ret = of_load_pse_pi_pairsets(node, &pi, npairsets);
> +		if (ret)
> +			goto out;
> +
> +		of_node_get(node);
> +		pi.np = node;
> +		memcpy(&pcdev->pi[id], &pi, sizeof(pi));
> +	}
> +
> +	of_node_put(pis);
> +	return 0;
> +
> +out:
> +	for (i = 0; i <= pcdev->nr_lines; i++) {
> +		of_node_put(pcdev->pi[i].pairset[0].np);
> +		of_node_put(pcdev->pi[i].pairset[1].np);
> +		of_node_put(pcdev->pi[i].np);
> +	}
> +	of_node_put(node);
> +	of_node_put(pis);
> +	kfree(pcdev->pi);
> +	return ret;
>  }
>  
>  /**
> @@ -67,16 +166,18 @@ static int of_pse_simple_xlate(struct pse_controller_dev *pcdev,
>   */
>  int pse_controller_register(struct pse_controller_dev *pcdev)
>  {
> -	if (!pcdev->of_xlate) {
> -		if (pcdev->of_pse_n_cells == 0)
> -			pcdev->of_xlate = of_pse_zero_xlate;
> -		else if (pcdev->of_pse_n_cells == 1)
> -			pcdev->of_xlate = of_pse_simple_xlate;
> -	}
> +	int ret;
>  
>  	mutex_init(&pcdev->lock);
>  	INIT_LIST_HEAD(&pcdev->pse_control_head);
>  
> +	if (!pcdev->nr_lines)
> +		pcdev->nr_lines = 1;
> +
> +	ret = of_load_pse_pis(pcdev);
> +	if (ret)
> +		return ret;
> +
>  	mutex_lock(&pse_list_mutex);
>  	list_add(&pcdev->list, &pse_controller_list);
>  	mutex_unlock(&pse_list_mutex);
> @@ -91,6 +192,14 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
>   */
>  void pse_controller_unregister(struct pse_controller_dev *pcdev)
>  {
> +	int i;
> +
> +	for (i = 0; i <= pcdev->nr_lines; i++) {
> +		of_node_put(pcdev->pi[i].pairset[0].np);
> +		of_node_put(pcdev->pi[i].pairset[1].np);
> +		of_node_put(pcdev->pi[i].np);
> +	}
> +	kfree(pcdev->pi);

Same pattern was already used. It is better to move it to a separate
function.

>  	mutex_lock(&pse_list_mutex);
>  	list_del(&pcdev->list);
>  	mutex_unlock(&pse_list_mutex);
> @@ -203,8 +312,33 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index)
>  	return psec;
>  }
>  
> -struct pse_control *
> -of_pse_control_get(struct device_node *node)
> +static int of_pse_match_pi(struct pse_controller_dev *pcdev,
> +			   struct device_node *np)
> +{
> +	int i;
> +
> +	for (i = 0; i <= pcdev->nr_lines; i++) {
> +		if (pcdev->pi[i].np == np)
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int psec_id_legacy_xlate(struct pse_controller_dev *pcdev,
> +				const struct of_phandle_args *pse_spec)

rename legacy to some other name in all places.

> +{
> +	if (!pcdev->of_pse_n_cells)
> +		return 0;
> +
> +	if (pcdev->of_pse_n_cells > 1 ||
> +	    pse_spec->args[0] >= pcdev->nr_lines)
> +		return -EINVAL;
> +
> +	return pse_spec->args[0];
> +}
> +
> +struct pse_control *of_pse_control_get(struct device_node *node)
>  {
>  	struct pse_controller_dev *r, *pcdev;
>  	struct of_phandle_args args;
> @@ -222,7 +356,14 @@ of_pse_control_get(struct device_node *node)
>  	mutex_lock(&pse_list_mutex);
>  	pcdev = NULL;
>  	list_for_each_entry(r, &pse_controller_list, list) {
> -		if (args.np == r->dev->of_node) {
> +		if (!r->of_legacy) {
> +			ret = of_pse_match_pi(r, args.np);
> +			if (ret >= 0) {
> +				pcdev = r;
> +				psec_id = ret;
> +				break;
> +			}
> +		} else if (args.np == r->dev->of_node) {
>  			pcdev = r;
>  			break;
>  		}
> @@ -238,10 +379,12 @@ of_pse_control_get(struct device_node *node)
>  		goto out;
>  	}
>  
> -	psec_id = pcdev->of_xlate(pcdev, &args);
> -	if (psec_id < 0) {
> -		psec = ERR_PTR(psec_id);
> -		goto out;
> +	if (pcdev->of_legacy) {
> +		psec_id = psec_id_legacy_xlate(pcdev, &args);
> +		if (psec_id < 0) {
> +			psec = ERR_PTR(psec_id);
> +			goto out;
> +		}
>  	}
>  
>  	/* pse_list_mutex also protects the pcdev's pse_control list */
> diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
> index 19589571157f..01b3b9adfe2a 100644
> --- a/include/linux/pse-pd/pse.h
> +++ b/include/linux/pse-pd/pse.h
> @@ -64,6 +64,36 @@ struct device_node;
>  struct of_phandle_args;
>  struct pse_control;
>  
> +/* PSE PI pairset pinout can either be Alternative A or Alternative B */
> +enum pse_pi_pairset_pinout {
> +	ALTERNATIVE_A,
> +	ALTERNATIVE_B,
> +};
> +
> +/**
> + * struct pse_pi_pairset - PSE PI pairset entity describing the pinout
> + *			   alternative ant its phandle
> + *
> + * @pinout: description of the pinout alternative
> + * @np: device node pointer describing the pairset phandle
> + */
> +struct pse_pi_pairset {
> +	enum pse_pi_pairset_pinout pinout;
> +	struct device_node *np;
> +};
> +
> +/**
> + * struct pse_pi - PSE PI (Power Interface) entity as described in
> + *		   IEEE 802.3-2022 145.2.4
> + *
> + * @pairset: table of the PSE PI pinout alternative for the two pairset
> + * @np: device node pointer of the PSE PI node
> + */
> +struct pse_pi {
> +	struct pse_pi_pairset pairset[2];
> +	struct device_node *np;
> +};
> +
>  /**
>   * struct pse_controller_dev - PSE controller entity that might
>   *                             provide multiple PSE controls
> @@ -73,11 +103,11 @@ struct pse_control;
>   * @pse_control_head: head of internal list of requested PSE controls
>   * @dev: corresponding driver model device struct
>   * @of_pse_n_cells: number of cells in PSE line specifiers
> - * @of_xlate: translation function to translate from specifier as found in the
> - *            device tree to id as given to the PSE control ops
>   * @nr_lines: number of PSE controls in this controller device
>   * @lock: Mutex for serialization access to the PSE controller
>   * @types: types of the PSE controller
> + * @pi: table of PSE PIs described in this controller device
> + * @of_legacy: flag set if the pse_pis devicetree node is not used
>   */
>  struct pse_controller_dev {
>  	const struct pse_controller_ops *ops;
> @@ -86,11 +116,11 @@ struct pse_controller_dev {
>  	struct list_head pse_control_head;
>  	struct device *dev;
>  	int of_pse_n_cells;
> -	int (*of_xlate)(struct pse_controller_dev *pcdev,
> -			const struct of_phandle_args *pse_spec);
>  	unsigned int nr_lines;
>  	struct mutex lock;
>  	enum ethtool_pse_types types;
> +	struct pse_pi *pi;
> +	bool of_legacy;
>  };
>  
>  #if IS_ENABLED(CONFIG_PSE_CONTROLLER)

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

