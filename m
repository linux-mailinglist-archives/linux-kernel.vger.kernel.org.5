Return-Path: <linux-kernel+bounces-51669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F2E848E19
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799372834B5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4BF224E6;
	Sun,  4 Feb 2024 13:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oFuW85XO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DA4224D2
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707053875; cv=none; b=JLjJdDPHopWC+YgpwOpv/7KxhZA2L/pm8p3yBDCOUFdVl3z43NBiatTBxhRcoH3ShcGHcmWyKVR6eovyoxuH9ctBZOMn+5LNKLsl0peK672b2OWyevS1QZu2Ha8L1Qr01CFrEzt3IB1UqlALJ4jNIZwlcACmhMBbTbjNvMKteE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707053875; c=relaxed/simple;
	bh=KP8u3fWUJbcqRt1L9NHgQfOHs7X67+rebC955OVmA3A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=g8jaOdmLIQ32KFeux04ykMACRhCSY2DtiOJY2c+XS5cy8ZNjB+kOZqk65cQ8fTVjRzYMjf11aUAu499KrUZL14llvZCPz9iBqeVyZlpvaeryfKTRZSWeJhs2eLXGgswqkgrTJwrNkkVScdDCd4ZKy8T4HUu4JzFinqiosoyBQAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oFuW85XO; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707053874; x=1738589874;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KP8u3fWUJbcqRt1L9NHgQfOHs7X67+rebC955OVmA3A=;
  b=oFuW85XO8o1CpQB87j0ce+QIMtYRWRRQQDDiKU/tFiOIccHXb2ZCyYO6
   1rIurULkRLW0u6hUbdZQhcFeYh9NEcI6JbnPYa17B/98b19SfZ4LpQmwK
   a4vKlZ+o9TpH0RNZANO6ztvOtmbG0tB4xDroQRE+fOtK36JinPdoIVcyO
   /hdIkqOIxVxRWr9+BltqGkT/hUvmXa7bIqSQ0N9gqt5susBuNv4ox4lBZ
   O+l+9rMbf5IWNg4tf72XbbLOrCovKp9SC9YRHMeen/muBGOdMpUYPNcbn
   fN9YaFHK2wAaFWMzAW60syjVyS2s/7vWLuNIy6m1Pq0YlkOGCeYWw44Gl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="310329"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="310329"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 05:37:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="497596"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 04 Feb 2024 05:37:51 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWcgu-0006Me-2U;
	Sun, 04 Feb 2024 13:37:48 +0000
Date: Sun, 4 Feb 2024 21:37:01 +0800
From: kernel test robot <lkp@intel.com>
To: Stephen Boyd <stephen.boyd@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: drivers/of/base.c:1337:73: sparse: sparse: incorrect type in
 initializer (different base types)
Message-ID: <202402042134.GEb3Bgwl-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3f24fcdacd40c70dd2949c1cfd8cc2e75942a9e3
commit: bd6f2fd5a1d52198468c5cdc3c2472362dff5aaa of: Support parsing phandle argument lists through a nexus node
date:   6 years ago
config: x86_64-randconfig-x051-20230705 (https://download.01.org/0day-ci/archive/20240204/202402042134.GEb3Bgwl-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240204/202402042134.GEb3Bgwl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402042134.GEb3Bgwl-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/of/base.c:1337:73: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __be32 @@     got int @@
   drivers/of/base.c:1337:73: sparse:     expected restricted __be32
   drivers/of/base.c:1337:73: sparse:     got int
   drivers/of/base.c:233: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Checks if the given "prop_name" property holds the physical id of the
   drivers/of/base.c:965: warning: Function parameter or member 'match' not described in 'of_find_matching_node_and_match'
   drivers/of/base.c:1550: warning: Function parameter or member 'np' not described in '__of_add_property'
   drivers/of/base.c:1550: warning: Function parameter or member 'prop' not described in '__of_add_property'
   drivers/of/base.c:1571: warning: Function parameter or member 'np' not described in 'of_add_property'
   drivers/of/base.c:1571: warning: Function parameter or member 'prop' not described in 'of_add_property'
   drivers/of/base.c:1620: warning: Function parameter or member 'np' not described in 'of_remove_property'
   drivers/of/base.c:1620: warning: Function parameter or member 'prop' not described in 'of_remove_property'
   drivers/of/base.c:1854: warning: Function parameter or member 'dn' not described in 'of_console_check'
   drivers/of/base.c:1854: warning: Function parameter or member 'name' not described in 'of_console_check'
   drivers/of/base.c:1854: warning: Function parameter or member 'index' not described in 'of_console_check'
   drivers/of/base.o: warning: objtool: of_print_phandle_args()+0x7a: sibling call from callable instruction with modified stack frame
   drivers/of/base.o: warning: objtool: of_print_phandle_args.cold()+0x12: sibling call from callable instruction with modified stack frame

vim +1337 drivers/of/base.c

  1285	
  1286	/**
  1287	 * of_parse_phandle_with_args_map() - Find a node pointed by phandle in a list and remap it
  1288	 * @np:		pointer to a device tree node containing a list
  1289	 * @list_name:	property name that contains a list
  1290	 * @stem_name:	stem of property names that specify phandles' arguments count
  1291	 * @index:	index of a phandle to parse out
  1292	 * @out_args:	optional pointer to output arguments structure (will be filled)
  1293	 *
  1294	 * This function is useful to parse lists of phandles and their arguments.
  1295	 * Returns 0 on success and fills out_args, on error returns appropriate errno
  1296	 * value. The difference between this function and of_parse_phandle_with_args()
  1297	 * is that this API remaps a phandle if the node the phandle points to has
  1298	 * a <@stem_name>-map property.
  1299	 *
  1300	 * Caller is responsible to call of_node_put() on the returned out_args->np
  1301	 * pointer.
  1302	 *
  1303	 * Example:
  1304	 *
  1305	 * phandle1: node1 {
  1306	 *	#list-cells = <2>;
  1307	 * }
  1308	 *
  1309	 * phandle2: node2 {
  1310	 *	#list-cells = <1>;
  1311	 * }
  1312	 *
  1313	 * phandle3: node3 {
  1314	 * 	#list-cells = <1>;
  1315	 * 	list-map = <0 &phandle2 3>,
  1316	 * 		   <1 &phandle2 2>,
  1317	 * 		   <2 &phandle1 5 1>;
  1318	 *	list-map-mask = <0x3>;
  1319	 * };
  1320	 *
  1321	 * node4 {
  1322	 *	list = <&phandle1 1 2 &phandle3 0>;
  1323	 * }
  1324	 *
  1325	 * To get a device_node of the `node2' node you may call this:
  1326	 * of_parse_phandle_with_args(node4, "list", "list", 1, &args);
  1327	 */
  1328	int of_parse_phandle_with_args_map(const struct device_node *np,
  1329					   const char *list_name,
  1330					   const char *stem_name,
  1331					   int index, struct of_phandle_args *out_args)
  1332	{
  1333		char *cells_name, *map_name = NULL, *mask_name = NULL;
  1334		char *pass_name = NULL;
  1335		struct device_node *cur, *new = NULL;
  1336		const __be32 *map, *mask, *pass;
> 1337		static const __be32 dummy_mask[] = { [0 ... MAX_PHANDLE_ARGS] = ~0 };
  1338		static const __be32 dummy_pass[] = { [0 ... MAX_PHANDLE_ARGS] = 0 };
  1339		__be32 initial_match_array[MAX_PHANDLE_ARGS];
  1340		const __be32 *match_array = initial_match_array;
  1341		int i, ret, map_len, match;
  1342		u32 list_size, new_size;
  1343	
  1344		if (index < 0)
  1345			return -EINVAL;
  1346	
  1347		cells_name = kasprintf(GFP_KERNEL, "#%s-cells", stem_name);
  1348		if (!cells_name)
  1349			return -ENOMEM;
  1350	
  1351		ret = -ENOMEM;
  1352		map_name = kasprintf(GFP_KERNEL, "%s-map", stem_name);
  1353		if (!map_name)
  1354			goto free;
  1355	
  1356		mask_name = kasprintf(GFP_KERNEL, "%s-map-mask", stem_name);
  1357		if (!mask_name)
  1358			goto free;
  1359	
  1360		pass_name = kasprintf(GFP_KERNEL, "%s-map-pass-thru", stem_name);
  1361		if (!pass_name)
  1362			goto free;
  1363	
  1364		ret = __of_parse_phandle_with_args(np, list_name, cells_name, 0, index,
  1365						   out_args);
  1366		if (ret)
  1367			goto free;
  1368	
  1369		/* Get the #<list>-cells property */
  1370		cur = out_args->np;
  1371		ret = of_property_read_u32(cur, cells_name, &list_size);
  1372		if (ret < 0)
  1373			goto put;
  1374	
  1375		/* Precalculate the match array - this simplifies match loop */
  1376		for (i = 0; i < list_size; i++)
  1377			initial_match_array[i] = cpu_to_be32(out_args->args[i]);
  1378	
  1379		ret = -EINVAL;
  1380		while (cur) {
  1381			/* Get the <list>-map property */
  1382			map = of_get_property(cur, map_name, &map_len);
  1383			if (!map) {
  1384				ret = 0;
  1385				goto free;
  1386			}
  1387			map_len /= sizeof(u32);
  1388	
  1389			/* Get the <list>-map-mask property (optional) */
  1390			mask = of_get_property(cur, mask_name, NULL);
  1391			if (!mask)
  1392				mask = dummy_mask;
  1393			/* Iterate through <list>-map property */
  1394			match = 0;
  1395			while (map_len > (list_size + 1) && !match) {
  1396				/* Compare specifiers */
  1397				match = 1;
  1398				for (i = 0; i < list_size; i++, map_len--)
  1399					match &= !((match_array[i] ^ *map++) & mask[i]);
  1400	
  1401				of_node_put(new);
  1402				new = of_find_node_by_phandle(be32_to_cpup(map));
  1403				map++;
  1404				map_len--;
  1405	
  1406				/* Check if not found */
  1407				if (!new)
  1408					goto put;
  1409	
  1410				if (!of_device_is_available(new))
  1411					match = 0;
  1412	
  1413				ret = of_property_read_u32(new, cells_name, &new_size);
  1414				if (ret)
  1415					goto put;
  1416	
  1417				/* Check for malformed properties */
  1418				if (WARN_ON(new_size > MAX_PHANDLE_ARGS))
  1419					goto put;
  1420				if (map_len < new_size)
  1421					goto put;
  1422	
  1423				/* Move forward by new node's #<list>-cells amount */
  1424				map += new_size;
  1425				map_len -= new_size;
  1426			}
  1427			if (!match)
  1428				goto put;
  1429	
  1430			/* Get the <list>-map-pass-thru property (optional) */
  1431			pass = of_get_property(cur, pass_name, NULL);
  1432			if (!pass)
  1433				pass = dummy_pass;
  1434	
  1435			/*
  1436			 * Successfully parsed a <list>-map translation; copy new
  1437			 * specifier into the out_args structure, keeping the
  1438			 * bits specified in <list>-map-pass-thru.
  1439			 */
  1440			match_array = map - new_size;
  1441			for (i = 0; i < new_size; i++) {
  1442				__be32 val = *(map - new_size + i);
  1443	
  1444				if (i < list_size) {
  1445					val &= ~pass[i];
  1446					val |= cpu_to_be32(out_args->args[i]) & pass[i];
  1447				}
  1448	
  1449				out_args->args[i] = be32_to_cpu(val);
  1450			}
  1451			out_args->args_count = list_size = new_size;
  1452			/* Iterate again with new provider */
  1453			out_args->np = new;
  1454			of_node_put(cur);
  1455			cur = new;
  1456		}
  1457	put:
  1458		of_node_put(cur);
  1459		of_node_put(new);
  1460	free:
  1461		kfree(mask_name);
  1462		kfree(map_name);
  1463		kfree(cells_name);
  1464		kfree(pass_name);
  1465	
  1466		return ret;
  1467	}
  1468	EXPORT_SYMBOL(of_parse_phandle_with_args_map);
  1469	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

