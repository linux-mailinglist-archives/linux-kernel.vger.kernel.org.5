Return-Path: <linux-kernel+bounces-9292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF5781C387
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F1BCB22818
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 03:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D43223D0;
	Fri, 22 Dec 2023 03:33:55 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463B717D3;
	Fri, 22 Dec 2023 03:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rGWIB-00Dgpy-KJ; Fri, 22 Dec 2023 11:33:44 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 22 Dec 2023 11:33:54 +0800
Date: Fri, 22 Dec 2023 11:33:54 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Gonglei <arei.gonglei@huawei.com>
Cc: linux-crypto@vger.kernel.org, mst@redhat.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, lixiao91@huawei.com,
	wangyangxin <wangyangxin1@huawei.com>
Subject: Re: [PATCH 2/2] crypto: virtio-crypto: Fix gcc check warnings
Message-ID: <ZYUDop1Cv1ddrqQf@gondor.apana.org.au>
References: <1702294936-61080-1-git-send-email-arei.gonglei@huawei.com>
 <1702294936-61080-3-git-send-email-arei.gonglei@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1702294936-61080-3-git-send-email-arei.gonglei@huawei.com>

On Mon, Dec 11, 2023 at 07:42:16PM +0800, Gonglei wrote:
>
>  static inline int virtio_crypto_get_current_node(void)
>  {
> -	int cpu, node;
> +	int node;
>  
> -	cpu = get_cpu();
> -	node = topology_physical_package_id(cpu);
> +	node = topology_physical_package_id(get_cpu());

This looks like a bogus warning.  I think we should do something
like this instead:

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index ae81a7191c1c..0cb43986061b 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -191,7 +191,7 @@ DECLARE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
 #define cpu_data(cpu)		per_cpu(cpu_info, cpu)
 #else
 #define cpu_info		boot_cpu_data
-#define cpu_data(cpu)		boot_cpu_data
+#define cpu_data(cpu)		((void)cpu, boot_cpu_data)
 #endif
 
 extern const struct seq_operations cpuinfo_op;

Please send this patch to the x86 people.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

