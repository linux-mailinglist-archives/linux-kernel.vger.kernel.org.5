Return-Path: <linux-kernel+bounces-42857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DAD8407C7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9C91F2412E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DBE657DF;
	Mon, 29 Jan 2024 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="e2yn44CU"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CB265BC0;
	Mon, 29 Jan 2024 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706536951; cv=none; b=r8bMP2+Hvy0pD27OQQbGxvvpIRW6Isa2DqVtX5u5l7MDlBz4/bNRDXc4RueZzE7oljfJycC8Gr1EtLQ20eJmrY1FgIXZ+fo8i1rMrhdvhQN6whkMyi21SvPc1vkKV3zM0OdT2FV8YV2jNgPdSK+As0KB/Xe7dtVlJfhoEw0TltM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706536951; c=relaxed/simple;
	bh=L4KkJnwVrBGQUIKiqLT2qMpTiEunFNdf+XRPrazNhak=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ST4puDH/qTl1mqvflRYuyjASc/7s5+NonxKYXpw47biXGEEiFEy8Np7SBgPBdF7g7TGtxBChU4TEFX9TNsrlE30FgfsppY/dj2fRhTbNtrJqjhLeN1xHg+qQe9jKcyk2C9w3MVrerhU8mY7Ct244d+OlfL92fObYi81hR3RQPy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=e2yn44CU; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JoLe1UN+c2EeFCQy9sEnj68RJ0ig+af+SKvwxWjuQWA=;
  b=e2yn44CUOp1cHIZaYeaxmJa8j9XkL8tizIRKbPhrFL/pHQxOfh5MGUup
   gxzF2CvXtsIV1C+s+lP83EsH/yQV/zqEjMOo3Cnb+ZnAk9nhFnnekfIY7
   J0LWFVsAffe8cuufbMoQTHGke6EHVaAvkXOR1MP5zSVqKX5BdmgKCU6rw
   g=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.05,227,1701126000"; 
   d="scan'208";a="78115635"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 15:02:19 +0100
Date: Mon, 29 Jan 2024 15:02:19 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
cc: Julia Lawall <julia.lawall@inria.fr>, Jonathan Cameron <jic23@kernel.org>, 
    linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>, 
    Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org, 
    Nicolas Palix <nicolas.palix@imag.fr>, 
    Sumera Priyadarsini <sylphrenadin@gmail.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    linux-acpi@vger.kernel.org, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    =?ISO-8859-15?Q?Nuno_S=E1?= <nuno.sa@analog.com>
Subject: Re: [RFC PATCH 0/5] of: automate of_node_put() - new approach to
 loops.
In-Reply-To: <20240129114218.00003c34@Huawei.com>
Message-ID: <alpine.DEB.2.22.394.2401291455430.8649@hadrien>
References: <20240128160542.178315-1-jic23@kernel.org> <alpine.DEB.2.22.394.2401281903550.3119@hadrien> <20240129114218.00003c34@Huawei.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 29 Jan 2024, Jonathan Cameron wrote:

> On Sun, 28 Jan 2024 19:06:53 +0100 (CET)
> Julia Lawall <julia.lawall@inria.fr> wrote:
>
> > On Sun, 28 Jan 2024, Jonathan Cameron wrote:
> >
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > +CC includes peopleinterested in property.h equivalents to minimize
> > > duplication of discussion.  Outcome of this discussion will affect:
> > > https://lore.kernel.org/all/20240114172009.179893-1-jic23@kernel.org/
> > > [PATCH 00/13] device property / IIO: Use cleanup.h magic for fwnode_handle_put() handling.
> > >
> > > In discussion of previous approach with Rob Herring we talked about various
> > > ways to avoid a disconnect between the declaration of the __free(device_node)
> > > and the first non NULL assignment. Making this connection clear is useful for 2
> > > reasons:
> > > 1) Avoids out of order cleanup with respect to other cleanup.h usage.
> > > 2) Avoids disconnect between how cleanup is to be done and how the reference
> > >    was acquired in the first place.
> > >
> > > https://lore.kernel.org/all/20240117194743.GA2888190-robh@kernel.org/
> > >
> > > The options we discussed are:
> > >
> > > 1) Ignore this issue and merge original set.
> > >
> > > 2) Always put the declaration just before the for loop and don't set it NULL.
> > >
> > > {
> > > 	int ret;
> > >
> > > 	ret = ... and other fun code.
> > >
> > > 	struct device_node *child __free(device_node);
> > > 	for_each_child_of_node(np, child) {
> > > 	}
> > > }
> > >
> > > This works but careful review is needed to ensure that this unusual pattern is
> > > followed.  We don't set it to NULL as the loop will do that anyway if there are
> > > no child nodes, or the loop finishes without an early break or return.
> > >
> > > 3) Introduced the pointer to auto put device_node only within the
> > >    for loop scope.
> > >
> > > +#define for_each_child_of_node_scoped(parent, child) \
> > > +	for (struct device_node *child __free(device_node) =		\
> > > +	     of_get_next_child(parent, NULL);				\
> > > +	     child != NULL;						\
> > > +	     child = of_get_next_available_child(parent, child))
> > > +
> > >
> > > This series is presenting option 3.  I only implemented this loop out of
> > > all the similar ones and it is only compile tested.
> > >
> > > Disadvantage Rob raised is that it isn't obvious this macro will instantiate
> > > a struct device_node *child.  I can't see a way around that other than option 2
> > > above, but all suggestions welcome.  Note that if a conversion leaves an
> > > 'external' struct device_node *child variable, in many cases the compiler
> > > will catch that as an unused variable. We don't currently run shaddow
> > > variable detection in normal kernel builds, but that could also be used
> > > to catch such bugs.
> > >
> > > All comments welcome.
> >
> > It looks promising to get rid of a lot of clunky and error-prone
> > error-handling code.
>
> Absolutely. I think I spotted 2 bugs whilst just looking for places this pattern
> doesn't apply.  Will circle back to those once this discussion is resolved.
> I think I've taken dozen's of fixes for cases where these were missed over the years
> so hoping this means I'll never see another one!
>
> >
> > I guess that
> >
> > for_each_child_of_node_scoped(parent, struct device_node *, child)
> >
> > would seem too verbose?
>
> Intent just to make the allocated internal type clear?  Sure we can do that if
> it helps with making it clear something is being allocated.
> I can't think of a way this could be used with anything other than
> a struct device_node * as the second parameter but I guess it still helps
> 'hint' at what is going on..
>
> >
> > There are a lot of opportunities for device_node loops, but also for some
> > more obscure loops over other types.
>
> > And there are a lot of of_node_puts
> > that could be eliminated independent of loops.
>
> The non loop cases should be handled via the __free(device_node) as provided
> by patch 1.  We'll need to keep the declaration local and initial assignment
> together but that is easy enough to do and similar to the many other cleanup.h
> usecases that are surfacing.

I tried the following semantic patch:

@@
identifier x,f;
attribute name __free;
expression list es;
expression e;
statement S;
@@

{
.. when != S
struct device_node *x
+ __free(device_node)
;
.. when strict
x = f(es);
<... when any
     when != x = e
-of_node_put(x);
..>
-of_node_put(x);
}

It is written defensively in various ways:

when != S means tha tthe device_node declaration has t be at the top of
the block, perhaps with other declarations before it.

when strict means that all paths must lead from the declaration to the
initialization.  So there is no need to intiialize the variable to NULL,
as far as I understand.

when != x = e means that the declared variable is not reinitialized, which
would require keeping the previous of_node_put.

There is an of_node_put at the end of the block, so the use of __free
doesn't change the lifetime.

An unfortunate aspect of the last constraint is that some functions may
declare multiple device_node variables, and only one of the of_not_puts
can come at the very end of the block.  This can be solved by just running
the semantic patch again.

An alternative would be to move the initialization up to the declaration,
but the result was often a bit ugly, due to the various initialization
function calls having long names and argument lists.

The output is below.  I have looked quickly through all of the changes and
they all look reasonable, but have not tried compiling anything (which I
guess wouldn't currently work anyway).

julia

diff -u -p a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -4973,7 +4973,7 @@ static int dsi_probe(struct platform_dev

 	if (dsi->data->model == DSI_MODEL_OMAP4 ||
 	    dsi->data->model == DSI_MODEL_OMAP5) {
-		struct device_node *np;
+		struct device_node *np __free(device_node);

 		/*
 		 * The OMAP4/5 display DT bindings don't reference the padconf
@@ -4986,7 +4986,6 @@ static int dsi_probe(struct platform_dev
 			return -ENODEV;

 		dsi->syscon = syscon_node_to_regmap(np);
-		of_node_put(np);
 	}

 	/* DSI VCs initialization */
diff -u -p a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -43,7 +43,7 @@ static struct ics *xics_ics;
 void xics_update_irq_servers(void)
 {
 	int i, j;
-	struct device_node *np;
+	struct device_node *np __free(device_node);
 	u32 ilen;
 	const __be32 *ireg;
 	u32 hcpuid;
@@ -59,7 +59,6 @@ void xics_update_irq_servers(void)

 	ireg = of_get_property(np, "ibm,ppc-interrupt-gserver#s", &ilen);
 	if (!ireg) {
-		of_node_put(np);
 		return;
 	}

@@ -78,7 +77,6 @@ void xics_update_irq_servers(void)
 	}
 	pr_devel("xics: xics_default_distrib_server = 0x%x\n",
 		 xics_default_distrib_server);
-	of_node_put(np);
 }

 /* GIQ stuff, currently only supported on RTAS setups, will have
@@ -485,7 +483,7 @@ void __init xics_register_ics(struct ics

 static void __init xics_get_server_size(void)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node);
 	const __be32 *isize;

 	/* We fetch the interrupt server size from the first ICS node
@@ -498,8 +496,6 @@ static void __init xics_get_server_size(
 	isize = of_get_property(np, "ibm,interrupt-server#-size", NULL);
 	if (isize)
 		xics_interrupt_server_size = be32_to_cpu(*isize);
-
-	of_node_put(np);
 }

 void __init xics_init(void)
diff -u -p a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -146,12 +146,11 @@ static const struct of_device_id exynos_

 static void exynos_map_pmu(void)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node);

 	np = of_find_matching_node(NULL, exynos_dt_pmu_match);
 	if (np)
 		pmu_base_addr = of_iomap(np, 0);
-	of_node_put(np);
 }

 static void __init exynos_init_irq(void)
diff -u -p a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -236,12 +236,11 @@ SYSCALL_DEFINE3(pciconfig_iobase, long,
 	 * (bus 0 is HT root), we return the AGP one instead.
 	 */
 	if (in_bus == 0 && of_machine_is_compatible("MacRISC4")) {
-		struct device_node *agp;
+		struct device_node *agp __free(device_node);

 		agp = of_find_compatible_node(NULL, NULL, "u3-agp");
 		if (agp)
 			in_bus = 0xf0;
-		of_node_put(agp);
 	}

 	/* That syscall isn't quite compatible with PCI domains, but it's
diff -u -p a/drivers/video/fbdev/omap2/omapfb/dss/dss-of.c b/drivers/video/fbdev/omap2/omapfb/dss/dss-of.c
--- a/drivers/video/fbdev/omap2/omapfb/dss/dss-of.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dss-of.c
@@ -25,7 +25,7 @@ omapdss_of_get_next_port(const struct de
 		return NULL;

 	if (!prev) {
-		struct device_node *ports;
+		struct device_node *ports __free(device_node);
 		/*
 		 * It's the first call, we have to find a port subnode
 		 * within this node or within an optional 'ports' node.
@@ -35,11 +35,8 @@ omapdss_of_get_next_port(const struct de
 			parent = ports;

 		port = of_get_child_by_name(parent, "port");
-
-		/* release the 'ports' node */
-		of_node_put(ports);
 	} else {
-		struct device_node *ports;
+		struct device_node *ports __free(device_node);

 		ports = of_get_parent(prev);
 		if (!ports)
@@ -48,13 +45,10 @@ omapdss_of_get_next_port(const struct de
 		do {
 			port = of_get_next_child(ports, prev);
 			if (!port) {
-				of_node_put(ports);
 				return NULL;
 			}
 			prev = port;
 		} while (!of_node_name_eq(port, "port"));
-
-		of_node_put(ports);
 	}

 	return port;
diff -u -p a/drivers/opp/of.c b/drivers/opp/of.c
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -163,7 +163,7 @@ static void _opp_table_alloc_required_ta
 					     struct device_node *opp_np)
 {
 	struct opp_table **required_opp_tables;
-	struct device_node *required_np, *np;
+	struct device_node *required_np, *np __free(device_node);
 	bool lazy = false;
 	int count, i, size;

@@ -216,7 +216,6 @@ static void _opp_table_alloc_required_ta
 free_required_tables:
 	_opp_table_free_required_tables(opp_table);
 put_np:
-	of_node_put(np);
 }

 void _of_init_opp_table(struct opp_table *opp_table, struct device *dev,
diff -u -p a/drivers/gpu/drm/tiny/ofdrm.c b/drivers/gpu/drm/tiny/ofdrm.c
--- a/drivers/gpu/drm/tiny/ofdrm.c
+++ b/drivers/gpu/drm/tiny/ofdrm.c
@@ -253,7 +253,7 @@ static enum ofdrm_model display_get_mode
 		   of_device_is_compatible(of_node, "pci1014,21c")) {
 		model = OFDRM_MODEL_GXT2000;
 	} else if (of_node_name_prefix(of_node, "vga,Display-")) {
-		struct device_node *of_parent;
+		struct device_node *of_parent __free(device_node);
 		const __be32 *vendor_p, *device_p;

 		/* Look for AVIVO initialized by SLOF */
@@ -267,7 +267,6 @@ static enum ofdrm_model display_get_mode
 			if (is_avivo(vendor, device))
 				model = OFDRM_MODEL_AVIVO;
 		}
-		of_node_put(of_parent);
 	} else if (of_device_is_compatible(of_node, "qemu,std-vga")) {
 		model = OFDRM_MODEL_QEMU;
 	}
diff -u -p a/arch/arm/mach-versatile/versatile.c b/arch/arm/mach-versatile/versatile.c
--- a/arch/arm/mach-versatile/versatile.c
+++ b/arch/arm/mach-versatile/versatile.c
@@ -123,7 +123,7 @@ static void __init versatile_init_early(
 static void __init versatile_dt_pci_init(void)
 {
 	u32 val;
-	struct device_node *np;
+	struct device_node *np __free(device_node);
 	struct property *newprop;

 	np = of_find_compatible_node(NULL, NULL, "arm,versatile-pci");
@@ -154,7 +154,6 @@ static void __init versatile_dt_pci_init
 	pr_info("Not plugged into PCI backplane!\n");

 out_put_node:
-	of_node_put(np);
 }

 static void __init versatile_dt_init(void)
diff -u -p a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -646,7 +646,7 @@ static int imx6_pm_stby_poweroff_probe(v

 void __init imx6_pm_ccm_init(const char *ccm_compat)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node);
 	u32 val;

 	np = of_find_compatible_node(NULL, NULL, ccm_compat);
@@ -663,8 +663,6 @@ void __init imx6_pm_ccm_init(const char

 	if (of_property_read_bool(np, "fsl,pmic-stby-poweroff"))
 		imx6_pm_stby_poweroff_probe();
-
-	of_node_put(np);
 }

 void __init imx6q_pm_init(void)
diff -u -p a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -210,7 +210,7 @@ static void __init pnv_setup_arch(void)

 static void __init pnv_add_hw_description(void)
 {
-	struct device_node *dn;
+	struct device_node *dn __free(device_node);
 	const char *s;

 	dn = of_find_node_by_path("/ibm,opal/firmware");
@@ -223,8 +223,6 @@ static void __init pnv_add_hw_descriptio

 	if (of_property_read_string(dn, "mi-version", &s) == 0)
 		seq_buf_printf(&ppc_hw_desc, "mi:%s ", s);
-
-	of_node_put(dn);
 }

 static void __init pnv_init(void)
diff -u -p a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -202,7 +202,7 @@ static struct property gic_frequency_pro

 static void update_gic_frequency_dt(void)
 {
-	struct device_node *node;
+	struct device_node *node __free(device_node);

 	gic_frequency_dt = cpu_to_be32(gic_frequency);

@@ -214,8 +214,6 @@ static void update_gic_frequency_dt(void

 	if (of_update_property(node, &gic_frequency_prop) < 0)
 		pr_err("error updating gic frequency property\n");
-
-	of_node_put(node);
 }

 #endif
diff -u -p a/arch/powerpc/sysdev/mpic_msgr.c b/arch/powerpc/sysdev/mpic_msgr.c
--- a/arch/powerpc/sysdev/mpic_msgr.c
+++ b/arch/powerpc/sysdev/mpic_msgr.c
@@ -146,16 +146,14 @@ static int mpic_msgr_block_number(struct

 	for (index = 0; index < number_of_blocks; ++index) {
 		struct property *prop;
-		struct device_node *tn;
+		struct device_node *tn __free(device_node);

 		snprintf(buf, sizeof(buf), "mpic-msgr-block%d", index);
 		prop = of_find_property(aliases, buf, NULL);
 		tn = of_find_node_by_path(prop->value);
 		if (node == tn) {
-			of_node_put(tn);
 			break;
 		}
-		of_node_put(tn);
 	}
 	of_node_put(aliases);

diff -u -p a/arch/powerpc/platforms/52xx/mpc52xx_pci.c b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
--- a/arch/powerpc/platforms/52xx/mpc52xx_pci.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
@@ -408,12 +408,11 @@ mpc52xx_add_bridge(struct device_node *n

 void __init mpc52xx_setup_pci(void)
 {
-	struct device_node *pci;
+	struct device_node *pci __free(device_node);

 	pci = of_find_matching_node(NULL, mpc52xx_pci_ids);
 	if (!pci)
 		return;

 	mpc52xx_add_bridge(pci);
-	of_node_put(pci);
 }
diff -u -p a/arch/nios2/kernel/cpuinfo.c b/arch/nios2/kernel/cpuinfo.c
--- a/arch/nios2/kernel/cpuinfo.c
+++ b/arch/nios2/kernel/cpuinfo.c
@@ -30,7 +30,7 @@ static inline u32 fcpu(struct device_nod

 void __init setup_cpuinfo(void)
 {
-	struct device_node *cpu;
+	struct device_node *cpu __free(device_node);
 	const char *str;
 	int len;

@@ -107,8 +107,6 @@ void __init setup_cpuinfo(void)
 	cpuinfo.reset_addr = fcpu(cpu, "altr,reset-addr");
 	cpuinfo.exception_addr = fcpu(cpu, "altr,exception-addr");
 	cpuinfo.fast_tlb_miss_exc_addr = fcpu(cpu, "altr,fast-tlb-miss-addr");
-
-	of_node_put(cpu);
 }

 #ifdef CONFIG_PROC_FS
diff -u -p a/drivers/clk/davinci/da8xx-cfgchip.c b/drivers/clk/davinci/da8xx-cfgchip.c
--- a/drivers/clk/davinci/da8xx-cfgchip.c
+++ b/drivers/clk/davinci/da8xx-cfgchip.c
@@ -749,11 +749,10 @@ static int da8xx_cfgchip_probe(struct pl

 	clk_init = device_get_match_data(dev);
 	if (clk_init) {
-		struct device_node *parent;
+		struct device_node *parent __free(device_node);

 		parent = of_get_parent(dev->of_node);
 		regmap = syscon_node_to_regmap(parent);
-		of_node_put(parent);
 	} else if (pdev->id_entry && pdata) {
 		clk_init = (void *)pdev->id_entry->driver_data;
 		regmap = pdata->cfgchip;
diff -u -p a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -490,7 +490,7 @@ static void __init init_bandit(struct pc
  */
 static void __init init_p2pbridge(void)
 {
-	struct device_node *p2pbridge;
+	struct device_node *p2pbridge __free(device_node);
 	struct pci_controller* hose;
 	u8 bus, devfn;
 	u16 val;
@@ -521,7 +521,6 @@ static void __init init_p2pbridge(void)
 	val &= ~PCI_BRIDGE_CTL_MASTER_ABORT;
 	early_write_config_word(hose, bus, devfn, PCI_BRIDGE_CONTROL, val);
 done:
-	of_node_put(p2pbridge);
 }

 static void __init init_second_ohare(void)
diff -u -p a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/mailbox.c
@@ -116,7 +116,7 @@ static int mailbox_chan_validate(struct

 	/* Bail out if provided shmem descriptors do not refer distinct areas  */
 	if (num_sh > 1) {
-		struct device_node *np_tx, *np_rx;
+		struct device_node *np_tx, *np_rx __free(device_node);

 		np_tx = of_parse_phandle(np, "shmem", 0);
 		np_rx = of_parse_phandle(np, "shmem", 1);
@@ -127,7 +127,6 @@ static int mailbox_chan_validate(struct
 		}

 		of_node_put(np_tx);
-		of_node_put(np_rx);
 	}

 	/* Calculate channels IDs to use depending on mboxes/shmem layout */
diff -u -p a/drivers/sbus/char/envctrl.c b/drivers/sbus/char/envctrl.c
--- a/drivers/sbus/char/envctrl.c
+++ b/drivers/sbus/char/envctrl.c
@@ -899,7 +899,7 @@ static void envctrl_init_i2c_child(struc
 	 * 'NULL' monitor type.
 	 */
 	if (ENVCTRL_CPCI_IGNORED_NODE == pchild->addr) {
-		struct device_node *root_node;
+		struct device_node *root_node __free(device_node);
 		int len;

 		root_node = of_find_node_by_path("/");
@@ -907,10 +907,8 @@ static void envctrl_init_i2c_child(struc
 			for (len = 0; len < PCF8584_MAX_CHANNELS; ++len) {
 				pchild->mon_type[len] = ENVCTRL_NOMON;
 			}
-			of_node_put(root_node);
 			return;
 		}
-		of_node_put(root_node);
 	}

 	/* Get the monitor channels. */
diff -u -p a/drivers/of/unittest.c b/drivers/of/unittest.c
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1053,7 +1053,7 @@ static void __init of_unittest_pci_dma_r

 static void __init of_unittest_bus_ranges(void)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node);
 	struct of_range range;
 	struct of_range_parser parser;
 	struct resource res;
@@ -1118,13 +1118,11 @@ static void __init of_unittest_bus_range
 		}
 		i++;
 	}
-
-	of_node_put(np);
 }

 static void __init of_unittest_bus_3cell_ranges(void)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node);
 	struct of_range range;
 	struct of_range_parser parser;
 	int i = 0;
@@ -1173,13 +1171,11 @@ static void __init of_unittest_bus_3cell
 		}
 		i++;
 	}
-
-	of_node_put(np);
 }

 static void __init of_unittest_reg(void)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node);
 	int ret;
 	u64 addr, size;

@@ -1194,8 +1190,6 @@ static void __init of_unittest_reg(void)
 		np, ret);
 	unittest(addr == 0x1000, "of_property_read_reg(%pOF) untranslated address (%llx) incorrect\n",
 		np, addr);
-
-	of_node_put(np);
 }

 struct of_unittest_expected_res {
diff -u -p a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -1065,11 +1065,10 @@ static void __init _clockgen_init(struct
 static void __init legacy_init_clockgen(struct device_node *np)
 {
 	if (!clockgen.node) {
-		struct device_node *parent_np;
+		struct device_node *parent_np __free(device_node);

 		parent_np = of_get_parent(np);
 		_clockgen_init(parent_np, true);
-		of_node_put(parent_np);
 	}
 }

diff -u -p a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -443,7 +443,7 @@ static void __init mpc512x_psc_fifo_init

 static void __init mpc512x_restart_init(void)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node);
 	const char *reset_compat;

 	reset_compat = mpc512x_select_reset_compat();
@@ -452,7 +452,6 @@ static void __init mpc512x_restart_init(
 		return;

 	reset_module_base = of_iomap(np, 0);
-	of_node_put(np);
 }

 void __init mpc512x_init_early(void)
diff -u -p a/drivers/pci/of.c b/drivers/pci/of.c
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -610,7 +610,7 @@ int devm_of_pci_bridge_init(struct devic

 void of_pci_remove_node(struct pci_dev *pdev)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node);

 	np = pci_device_to_OF_node(pdev);
 	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
@@ -619,7 +619,6 @@ void of_pci_remove_node(struct pci_dev *

 	of_changeset_revert(np->data);
 	of_changeset_destroy(np->data);
-	of_node_put(np);
 }

 void of_pci_make_dev_node(struct pci_dev *pdev)
diff -u -p a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -1320,7 +1320,7 @@ static int ffa_sched_recv_irq_map(void)

 	if (acpi_disabled) {
 		struct of_phandle_args oirq = {};
-		struct device_node *gic;
+		struct device_node *gic __free(device_node);

 		/* Only GICv3 supported currently with the device tree */
 		gic = of_find_compatible_node(NULL, NULL, "arm,gic-v3");
@@ -1331,7 +1331,6 @@ static int ffa_sched_recv_irq_map(void)
 		oirq.args_count = 1;
 		oirq.args[0] = sr_intid;
 		irq = irq_create_of_mapping(&oirq);
-		of_node_put(gic);
 #ifdef CONFIG_ACPI
 	} else {
 		irq = acpi_register_gsi(NULL, sr_intid, ACPI_EDGE_SENSITIVE,
diff -u -p a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
--- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -182,7 +182,7 @@ unsigned int flipper_pic_get_irq(void)

 void __init flipper_pic_probe(void)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node);

 	np = of_find_compatible_node(NULL, NULL, "nintendo,flipper-pic");
 	BUG_ON(!np);
@@ -191,8 +191,6 @@ void __init flipper_pic_probe(void)
 	BUG_ON(!flipper_irq_host);

 	irq_set_default_host(flipper_irq_host);
-
-	of_node_put(np);
 }

 /*
diff -u -p a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -6440,7 +6440,7 @@ static int kvmppc_book3s_init_hv(void)
 #ifdef CONFIG_SMP
 	if (!xics_on_xive() && !kvmhv_on_pseries() &&
 	    !local_paca->kvm_hstate.xics_phys) {
-		struct device_node *np;
+		struct device_node *np __free(device_node);

 		np = of_find_compatible_node(NULL, NULL, "ibm,opal-intc");
 		if (!np) {
@@ -6448,8 +6448,6 @@ static int kvmppc_book3s_init_hv(void)
 			r = -ENODEV;
 			goto err;
 		}
-		/* presence of intc confirmed - node can be dropped again */
-		of_node_put(np);
 	}
 #endif

diff -u -p a/arch/powerpc/platforms/pseries/rng.c b/arch/powerpc/platforms/pseries/rng.c
--- a/arch/powerpc/platforms/pseries/rng.c
+++ b/arch/powerpc/platforms/pseries/rng.c
@@ -27,11 +27,10 @@ static int pseries_get_random_long(unsig

 void __init pseries_rng_init(void)
 {
-	struct device_node *dn;
+	struct device_node *dn __free(device_node);

 	dn = of_find_compatible_node(NULL, NULL, "ibm,random");
 	if (!dn)
 		return;
 	ppc_md.get_random_seed = pseries_get_random_long;
-	of_node_put(dn);
 }
diff -u -p a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1795,12 +1795,11 @@ static struct extcon_dev *dwc3_get_extco
 	 */
 	np_phy = of_parse_phandle(dev->of_node, "phys", 0);
 	if (of_graph_is_present(np_phy)) {
-		struct device_node *np_conn;
+		struct device_node *np_conn __free(device_node);

 		np_conn = of_graph_get_remote_node(np_phy, -1, -1);
 		if (np_conn)
 			edev = extcon_find_edev_by_node(np_conn);
-		of_node_put(np_conn);
 	}
 	of_node_put(np_phy);

diff -u -p a/arch/arm/mach-bcm/platsmp-brcmstb.c b/arch/arm/mach-bcm/platsmp-brcmstb.c
--- a/arch/arm/mach-bcm/platsmp-brcmstb.c
+++ b/arch/arm/mach-bcm/platsmp-brcmstb.c
@@ -314,7 +314,7 @@ cleanup:
 static void __init brcmstb_cpu_ctrl_setup(unsigned int max_cpus)
 {
 	int rc;
-	struct device_node *np;
+	struct device_node *np __free(device_node);
 	char *name;

 	name = "brcm,brcmstb-smpboot";
@@ -333,7 +333,6 @@ static void __init brcmstb_cpu_ctrl_setu
 		goto out_put_node;

 out_put_node:
-	of_node_put(np);
 }

 static int brcmstb_boot_secondary(unsigned int cpu, struct task_struct *idle)
diff -u -p a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -201,7 +201,7 @@ void __init plat_mem_setup(void)

 void __init device_tree_init(void)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node);

 	unflatten_and_copy_device_tree();

@@ -209,7 +209,6 @@ void __init device_tree_init(void)
 	np = of_find_node_by_name(NULL, "cpus");
 	if (np && of_get_available_child_count(np) <= 1)
 		bmips_smp_enabled = 0;
-	of_node_put(np);
 }

 static int __init plat_dev_init(void)
diff -u -p a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -163,7 +163,7 @@ static phys_addr_t lbc_br_to_phys(const
  */
 static void p1022ds_set_monitor_port(enum fsl_diu_monitor_port port)
 {
-	struct device_node *guts_node;
+	struct device_node *guts_node __free(device_node);
 	struct device_node *lbc_node = NULL;
 	struct device_node *law_node = NULL;
 	struct ccsr_guts __iomem *guts;
@@ -362,7 +362,6 @@ exit:

 	of_node_put(law_node);
 	of_node_put(lbc_node);
-	of_node_put(guts_node);
 }

 /**
diff -u -p a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -882,7 +882,7 @@ static void opal_add_exported_attrs(stru
  */
 static void opal_export_attrs(void)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node);
 	struct kobject *kobj;
 	int rc;

@@ -894,7 +894,6 @@ static void opal_export_attrs(void)
 	kobj = kobject_create_and_add("exports", opal_kobj);
 	if (!kobj) {
 		pr_warn("kobject_create_and_add() of exports failed\n");
-		of_node_put(np);
 		return;
 	}

@@ -908,8 +907,6 @@ static void opal_export_attrs(void)
 				 np->parent, "symbol-map");
 	if (rc)
 		pr_warn("Error %d creating OPAL symbols file\n", rc);
-
-	of_node_put(np);
 }

 static void __init opal_dump_region_init(void)
@@ -950,13 +947,11 @@ static void __init opal_pdev_init(const

 static void __init opal_imc_init_dev(void)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node);

 	np = of_find_compatible_node(NULL, NULL, IMC_DTB_COMPAT);
 	if (np)
 		of_platform_device_create(np, NULL, NULL);
-
-	of_node_put(np);
 }

 static int kopald(void *unused)
diff -u -p a/arch/arm/mach-rockchip/pm.c b/arch/arm/mach-rockchip/pm.c
--- a/arch/arm/mach-rockchip/pm.c
+++ b/arch/arm/mach-rockchip/pm.c
@@ -304,7 +304,7 @@ void __init rockchip_suspend_init(void)
 {
 	const struct rockchip_pm_data *pm_data;
 	const struct of_device_id *match;
-	struct device_node *np;
+	struct device_node *np __free(device_node);
 	int ret;

 	np = of_find_matching_node_and_match(NULL, rockchip_pmu_of_device_ids,
@@ -327,5 +327,4 @@ void __init rockchip_suspend_init(void)
 	suspend_set_ops(pm_data->ops);

 out_put:
-	of_node_put(np);
 }
diff -u -p a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -99,7 +99,7 @@ static u32 __init imx8mq_soc_revision(vo
 static void __init imx8mm_soc_uid(void)
 {
 	void __iomem *ocotp_base;
-	struct device_node *np;
+	struct device_node *np __free(device_node);
 	struct clk *clk;
 	u32 offset = of_machine_is_compatible("fsl,imx8mp") ?
 		     IMX8MP_OCOTP_UID_OFFSET : 0;
@@ -125,7 +125,6 @@ static void __init imx8mm_soc_uid(void)
 	clk_disable_unprepare(clk);
 	clk_put(clk);
 	iounmap(ocotp_base);
-	of_node_put(np);
 }

 static u32 __init imx8mm_soc_revision(void)
diff -u -p a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -62,14 +62,13 @@

 static void cell_show_cpuinfo(struct seq_file *m)
 {
-	struct device_node *root;
+	struct device_node *root __free(device_node);
 	const char *model = "";

 	root = of_find_node_by_path("/");
 	if (root)
 		model = of_get_property(root, "model", NULL);
 	seq_printf(m, "machine\t\t: CHRP %s\n", model);
-	of_node_put(root);
 }

 static void cell_progress(char *s, unsigned short hex)
diff -u -p a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -1454,7 +1454,7 @@ static int ibmvfc_issue_fc_host_lip(stru
  **/
 static void ibmvfc_gather_partition_info(struct ibmvfc_host *vhost)
 {
-	struct device_node *rootdn;
+	struct device_node *rootdn __free(device_node);
 	const char *name;
 	const unsigned int *num;

@@ -1468,7 +1468,6 @@ static void ibmvfc_gather_partition_info
 	num = of_get_property(rootdn, "ibm,partition-no", NULL);
 	if (num)
 		vhost->partition_number = *num;
-	of_node_put(rootdn);
 }

 /**
diff -u -p a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -2102,7 +2102,7 @@ static int __init gic_validate_dist_vers
 /* Create all possible partitions at boot time */
 static void __init gic_populate_ppi_partitions(struct device_node *gic_node)
 {
-	struct device_node *parts_node, *child_part;
+	struct device_node *parts_node __free(device_node), *child_part;
 	int part_idx = 0, i;
 	int nr_parts;
 	struct partition_affinity *parts;
@@ -2194,7 +2194,6 @@ static void __init gic_populate_ppi_part
 	}

 out_put_node:
-	of_node_put(parts_node);
 }

 static void __init gic_of_setup_kvm_info(struct device_node *node)
diff -u -p a/arch/powerpc/platforms/85xx/socrates.c b/arch/powerpc/platforms/85xx/socrates.c
--- a/arch/powerpc/platforms/85xx/socrates.c
+++ b/arch/powerpc/platforms/85xx/socrates.c
@@ -40,7 +40,7 @@

 static void __init socrates_pic_init(void)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node);

 	struct mpic *mpic = mpic_alloc(NULL, 0, MPIC_BIG_ENDIAN,
 			0, 256, " OpenPIC  ");
@@ -53,7 +53,6 @@ static void __init socrates_pic_init(voi
 		return;
 	}
 	socrates_fpga_pic_init(np);
-	of_node_put(np);
 }

 /*
diff -u -p a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1654,7 +1654,7 @@ static void soctherm_init_hw_throt_cdev(
 {
 	struct device *dev = &pdev->dev;
 	struct tegra_soctherm *ts = dev_get_drvdata(dev);
-	struct device_node *np_stc, *np_stcc;
+	struct device_node *np_stc __free(device_node), *np_stcc;
 	const char *name;
 	int i;

@@ -1713,8 +1713,6 @@ static void soctherm_init_hw_throt_cdev(
 		}

 	}
-
-	of_node_put(np_stc);
 }

 /**
diff -u -p a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
--- a/arch/arm/mach-imx/system.c
+++ b/arch/arm/mach-imx/system.c
@@ -86,7 +86,7 @@ void __init imx1_reset_init(void __iomem
 void __init imx_init_l2cache(void)
 {
 	void __iomem *l2x0_base;
-	struct device_node *np;
+	struct device_node *np __free(device_node);
 	unsigned int val;

 	np = of_find_compatible_node(NULL, NULL, "arm,pl310-cache");
@@ -113,6 +113,5 @@ void __init imx_init_l2cache(void)

 	iounmap(l2x0_base);
 put_node:
-	of_node_put(np);
 }
 #endif
diff -u -p a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -758,7 +758,7 @@ static void sysrq_detect_reset_sequence(
 static void sysrq_of_get_keyreset_config(void)
 {
 	u32 key;
-	struct device_node *np;
+	struct device_node *np __free(device_node);
 	struct property *prop;
 	const __be32 *p;

@@ -781,8 +781,6 @@ static void sysrq_of_get_keyreset_config

 	/* Get reset timeout if any. */
 	of_property_read_u32(np, "timeout-ms", &sysrq_reset_downtime_ms);
-
-	of_node_put(np);
 }
 #else
 static void sysrq_of_get_keyreset_config(void)
diff -u -p a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -269,7 +269,7 @@ IRQCHIP_DECLARE(imx_gpc, "fsl,imx6q-gpc"

 void __init imx_gpc_check_dt(void)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node);

 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-gpc");
 	if (WARN_ON(!np))
@@ -281,5 +281,4 @@ void __init imx_gpc_check_dt(void)
 		/* map GPC, so that at least CPUidle and WARs keep working */
 		gpc_base = of_iomap(np, 0);
 	}
-	of_node_put(np);
 }
diff -u -p a/sound/soc/codecs/rk817_codec.c b/sound/soc/codecs/rk817_codec.c
--- a/sound/soc/codecs/rk817_codec.c
+++ b/sound/soc/codecs/rk817_codec.c
@@ -456,7 +456,7 @@ static const struct snd_soc_component_dr
 static void rk817_codec_parse_dt_property(struct device *dev,
 					 struct rk817_codec_priv *rk817)
 {
-	struct device_node *node;
+	struct device_node *node __free(device_node);

 	node = of_get_child_by_name(dev->parent->of_node, "codec");
 	if (!node) {
@@ -466,8 +466,6 @@ static void rk817_codec_parse_dt_propert

 	rk817->mic_in_differential =
 			of_property_read_bool(node, "rockchip,mic-in-differential");
-
-	of_node_put(node);
 }

 static int rk817_platform_probe(struct platform_device *pdev)
diff -u -p a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -627,7 +627,7 @@ static void __init smp_core99_setup_i2c_

 static void smp_core99_pfunc_tb_freeze(int freeze)
 {
-	struct device_node *cpus;
+	struct device_node *cpus __free(device_node);
 	struct pmf_args args;

 	cpus = of_find_node_by_path("/cpus");
@@ -635,7 +635,6 @@ static void smp_core99_pfunc_tb_freeze(i
 	args.count = 1;
 	args.u[0].v = !freeze;
 	pmf_call_function(cpus, "cpu-timebase", &args);
-	of_node_put(cpus);
 }

 #else /* CONFIG_PPC64 */
diff -u -p a/arch/arm/mach-omap2/omap-secure.c b/arch/arm/mach-omap2/omap-secure.c
--- a/arch/arm/mach-omap2/omap-secure.c
+++ b/arch/arm/mach-omap2/omap-secure.c
@@ -33,7 +33,7 @@ bool optee_available;

 static void __init omap_optee_init_check(void)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node);

 	/*
 	 * We only check that the OP-TEE node is present and available. The
@@ -43,7 +43,6 @@ static void __init omap_optee_init_check
 	np = of_find_node_by_path("/firmware/optee");
 	if (np && of_device_is_available(np))
 		optee_available = true;
-	of_node_put(np);
 }

 /**
diff -u -p a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -78,7 +78,7 @@ static void __init imx6q_enet_phy_init(v

 static void __init imx6q_1588_init(void)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node);
 	struct clk *ptp_clk, *fec_enet_ref;
 	struct clk *enet_ref;
 	struct regmap *gpr;
@@ -130,7 +130,6 @@ static void __init imx6q_1588_init(void)
 put_ptp_clk:
 	clk_put(ptp_clk);
 put_node:
-	of_node_put(np);
 }

 static void __init imx6q_axi_init(void)
diff -u -p a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/83xx/km83xx.c
--- a/arch/powerpc/platforms/83xx/km83xx.c
+++ b/arch/powerpc/platforms/83xx/km83xx.c
@@ -45,7 +45,7 @@ static void __init quirk_mpc8360e_qe_ene
 	 * RGMII AC values do not meet the specification
 	 */
 	uint svid = mfspr(SPRN_SVR);
-	struct	device_node *np_par;
+	struct	device_node *np_par __free(device_node);
 	struct	resource res;
 	void	__iomem *base;
 	int	ret;
@@ -113,7 +113,6 @@ static void __init quirk_mpc8360e_qe_ene
 	}
 	iounmap(base);
 out:
-	of_node_put(np_par);
 }

 /* ************************************************************************
diff -u -p a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -1113,7 +1113,7 @@ void rsnd_parse_connect_ssi(struct rsnd_
 {
 	struct rsnd_priv *priv = rsnd_rdai_to_priv(rdai);
 	struct device *dev = rsnd_priv_to_dev(priv);
-	struct device_node *node;
+	struct device_node *node __free(device_node);
 	struct device_node *np;
 	int i;

@@ -1139,8 +1139,6 @@ void rsnd_parse_connect_ssi(struct rsnd_
 			rsnd_ssi_connect(mod, &rdai->capture);
 		i++;
 	}
-
-	of_node_put(node);
 }

 struct rsnd_mod *rsnd_ssi_mod_get(struct rsnd_priv *priv, int id)
diff -u -p a/drivers/tty/serial/suncore.c b/drivers/tty/serial/suncore.c
--- a/drivers/tty/serial/suncore.c
+++ b/drivers/tty/serial/suncore.c
@@ -99,7 +99,7 @@ void sunserial_console_termios(struct co
 	} else if (of_node_name_eq(uart_dp, "lom-console")) {
 		mode = "9600,8,n,1,-";
 	} else {
-		struct device_node *dp;
+		struct device_node *dp __free(device_node);
 		char c;

 		c = 'a';
@@ -112,7 +112,6 @@ void sunserial_console_termios(struct co
 		mode = of_get_property(dp, mode_prop, NULL);
 		if (!mode)
 			mode = "9600,8,n,1,-";
-		of_node_put(dp);
 	}

 	cflag = CREAD | HUPCL | CLOCAL;
diff -u -p a/drivers/clk/clk-nomadik.c b/drivers/clk/clk-nomadik.c
--- a/drivers/clk/clk-nomadik.c
+++ b/drivers/clk/clk-nomadik.c
@@ -87,7 +87,7 @@ static const struct of_device_id nomadik

 static void __init nomadik_src_init(void)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node);
 	u32 val;

 	np = of_find_matching_node(NULL, nomadik_src_match);
@@ -134,7 +134,6 @@ static void __init nomadik_src_init(void
 	register_reboot_notifier(&nomadik_clk_reboot_notifier);

 out_put:
-	of_node_put(np);
 }

 /**
diff -u -p a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -99,7 +99,7 @@ static void chrp_show_cpuinfo(struct seq
 {
 	int i, sdramen;
 	unsigned int t;
-	struct device_node *root;
+	struct device_node *root __free(device_node);
 	const char *model = "";

 	root = of_find_node_by_path("/");
@@ -152,7 +152,6 @@ static void chrp_show_cpuinfo(struct seq
 			   gg2_cachetypes[(t>>2) & 3],
 			   gg2_cachemodes[t & 3]);
 	}
-	of_node_put(root);
 }

 /*
@@ -195,7 +194,7 @@ static void __init sio_fixup_irq(const c

 static void __init sio_init(void)
 {
-	struct device_node *root;
+	struct device_node *root __free(device_node);
 	const char *model;

 	root = of_find_node_by_path("/");
@@ -209,8 +208,6 @@ static void __init sio_init(void)
 		/* select logical device 1 (KBC/Mouse) */
 		sio_fixup_irq("mouse", 1, 12, 2);
 	}
-
-	of_node_put(root);
 }


@@ -364,7 +361,7 @@ static void chrp_8259_cascade(struct irq
  */
 static void __init chrp_find_openpic(void)
 {
-	struct device_node *np, *root;
+	struct device_node *np __free(device_node), *root;
 	int len, i, j;
 	int isu_size;
 	const unsigned int *iranges, *opprop = NULL;
@@ -438,7 +435,6 @@ static void __init chrp_find_openpic(voi
 	ppc_md.get_irq = mpic_get_irq;
  bail:
 	of_node_put(root);
-	of_node_put(np);
 }

 static void __init chrp_find_8259(void)
diff -u -p a/arch/powerpc/platforms/52xx/efika.c b/arch/powerpc/platforms/52xx/efika.c
--- a/arch/powerpc/platforms/52xx/efika.c
+++ b/arch/powerpc/platforms/52xx/efika.c
@@ -140,7 +140,7 @@ static void __init efika_pcisetup(void)

 static void efika_show_cpuinfo(struct seq_file *m)
 {
-	struct device_node *root;
+	struct device_node *root __free(device_node);
 	const char *revision;
 	const char *codegendescription;
 	const char *codegenvendor;
@@ -163,8 +163,6 @@ static void efika_show_cpuinfo(struct se

 	if (codegenvendor)
 		seq_printf(m, "vendor\t\t: %s\n", codegenvendor);
-
-	of_node_put(root);
 }

 #ifdef CONFIG_PM

