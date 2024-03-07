Return-Path: <linux-kernel+bounces-95770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9C487524E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8062831D7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C915B1FD;
	Thu,  7 Mar 2024 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9Ry2aqE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248AD8526A;
	Thu,  7 Mar 2024 14:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709823065; cv=none; b=qM3iHAm3oBGU1halIKpUc8u6MY1UmK6Upoc8w4IKVEQuQb+25EjoKYHbd1OLSsv8osblSSCkvNKIKyqVmofRUYKOJa4G64+Ev8TdHA9ZvHB/Thwp5pZ6yxbf3Q7SJmtKYH17NUBaqQAyMn9yKowTdK4AWEOxpIsu6YGnZUoxmJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709823065; c=relaxed/simple;
	bh=+8ei9aDD5izWfXGOrU5GYMqyDqmFCVXE9yaNWpl1EQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvqCRPoIBj4HUspeNOLuU9/gt2ztKDJMCNv2NvXNQhflNg+gn2EoSpusGKpADyFK9gia9/xH8+17xZmHJCWs4G9HuQPxGBr6byG4+ZX/N07cLzGIbkiuO2d0LzDX+3Wa3uRTS6KF496lUvyMe8/kMX/SK8S1+ZRvzCQFW+Ajr+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9Ry2aqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65331C433F1;
	Thu,  7 Mar 2024 14:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709823064;
	bh=+8ei9aDD5izWfXGOrU5GYMqyDqmFCVXE9yaNWpl1EQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A9Ry2aqEF7O9gBMf2orqRux/n+eQVd4ovBevC9rvzK2/WMu2MMDrcMkd/6FNJY/2T
	 dASWKh3BZ47i/0b/Sle3ZmhgMkcoWF+StNGl0jz9hs+BJsq0Twtn0NiPn9damkYiIt
	 QeUb/v6NZ1JB02rAdXIgOYCSGZmv/TFkkClA7ghFrrSw6gw+92o3C6BWiY152DyUPE
	 kJ7aFN9bdtgKStEJX8uRTzdaPzo4hFSbzt1hHYPkmAp62Fwo2iS3XZm5WEzSqCEPZQ
	 6Onm0MBcewJaBGfjjYmtF+68SjGJ0k5jSMZwFQqrGJoB8CTVTEB+oSU5jXiYo/qntK
	 XQkpMfZ3DMxIA==
Date: Thu, 7 Mar 2024 08:51:02 -0600
From: Rob Herring <robh@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Christian Brauner <brauner@kernel.org>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Damien Le Moal <dlemoal@kernel.org>, Min Li <min15.li@samsung.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Hannes Reinecke <hare@suse.de>,
	Christian Loehle <CLoehle@hyperstone.com>,
	Avri Altman <avri.altman@wdc.com>, Bean Huo <beanhuo@micron.com>,
	Yeqi Fu <asuk4.q@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
	Diping Zhang <diping.zhang@gl-inet.com>,
	Jianhui Zhao <zhaojh329@gmail.com>,
	Jieying Zeng <jieying.zeng@gl-inet.com>,
	Chad Monroe <chad.monroe@adtran.com>,
	Adam Fox <adam.fox@adtran.com>, John Crispin <john@phrozen.org>
Subject: Re: [RFC PATCH v2 1/8] dt-bindings: block: add basic bindings for
 block devices
Message-ID: <20240307145102.GA2550133-robh@kernel.org>
References: <cover.1709667858.git.daniel@makrotopia.org>
 <f70bb480aef6f55228a25ce20ff0e88e670e1b70.1709667858.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f70bb480aef6f55228a25ce20ff0e88e670e1b70.1709667858.git.daniel@makrotopia.org>

On Tue, Mar 05, 2024 at 08:23:20PM +0000, Daniel Golle wrote:
> Add bindings for block devices which are used to allow referencing
> nvmem bits on them.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  .../bindings/block/block-device.yaml          | 22 ++++++++
>  .../devicetree/bindings/block/partition.yaml  | 51 +++++++++++++++++++
>  .../devicetree/bindings/block/partitions.yaml | 20 ++++++++
>  3 files changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/block/block-device.yaml
>  create mode 100644 Documentation/devicetree/bindings/block/partition.yaml
>  create mode 100644 Documentation/devicetree/bindings/block/partitions.yaml
> 
> diff --git a/Documentation/devicetree/bindings/block/block-device.yaml b/Documentation/devicetree/bindings/block/block-device.yaml
> new file mode 100644
> index 0000000000000..c83ea525650ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/block/block-device.yaml
> @@ -0,0 +1,22 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/block/block-device.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: block storage device
> +
> +description: |
> +  This binding is generic and describes a block-oriented storage device.
> +
> +maintainers:
> +  - Daniel Golle <daniel@makrotopia.org>
> +
> +properties:
> +  partitions:
> +    $ref: /schemas/block/partitions.yaml
> +
> +  nvmem-layout:
> +    $ref: /schemas/nvmem/layouts/nvmem-layout.yaml#
> +
> +unevaluatedProperties: false
> diff --git a/Documentation/devicetree/bindings/block/partition.yaml b/Documentation/devicetree/bindings/block/partition.yaml
> new file mode 100644
> index 0000000000000..df561dd33cbc9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/block/partition.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/block/partition.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Partition on a block device
> +
> +description: |
> +  This binding describes a partition on a block storage device.
> +  Partitions may be matched by a combination of partition number, name,
> +  and UUID.
> +
> +maintainers:
> +  - Daniel Golle <daniel@makrotopia.org>
> +
> +properties:
> +  $nodename:
> +    pattern: '^block-partition-.+$'
> +
> +  partnum:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Matches partition by number if present.
> +
> +  partname:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Matches partition by PARTNAME if present.

Why do we need something new here? The existing fixed-partitions can 
already define block device partitions. It just matches by 
address/offset which works whether its MBR or GPT. Also, in DT we always 
have an address when there is an address.

I'm sure you want to statically define this and have it work even if the 
partitions move, but sorry...

> +
> +  uuid:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Matches partition by PARTUUID if present.

If this remains it will need some work in the dtschema tools. The reason 
is json-schema already has support for UUIDs as a defined 'format' key 
value and we should use that.

> +
> +  nvmem-layout:
> +    $ref: /schemas/nvmem/layouts/nvmem-layout.yaml#
> +    description:
> +      This container may reference an NVMEM layout parser.
> +
> +anyOf:
> +  - required:
> +      - partnum
> +
> +  - required:
> +      - partname
> +
> +  - required:
> +      - uuid
> +
> +unevaluatedProperties: false

