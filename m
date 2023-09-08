Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B9D7987F3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 15:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243632AbjIHNe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 09:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243593AbjIHNeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 09:34:22 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551B51BFF;
        Fri,  8 Sep 2023 06:34:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6mY/1VVGSvz6uDrRbvkOZzeoOtNH9vMuENWdsxxksHPb0IDCDg+CwfqXOGwCYl+XhfEd9WNMk+G9MX7/3IVyP1uB95HRt90AYOmPouQr7QZ0lwrpc9HDNYgtxo1Pb0nyPKFLjHHRM3of55Kxk/N5m2EJOv1KelT2XdfdgH2InxVcmylXt9OlWc8nV3XdWWHMUX3UMIAHUWUOCoSNzLBuPEWeyne13tfqOTnz4kXx46wHd3WL/08Ix2qsksbmDSa6Sdm8VBOXNF/BjDN7DGwZnBIIq4Wnc+1FzVu71/xUh8jnASAJ82ADZ51ihQrqIyHfSZk4HobdNlq5fVc9qba3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BS16mT6U7ksigGV4l4NLqWUfFQK5C5DsjU08zJ7G5k=;
 b=dv01hJkatjIuwTRVwDVzDYwZA1mHMVOdVwsd0eFEYuJHdY4zNhfKEOxRf14c2gONAmwVWJC3tOZG9DeZ7FqS1IhiUFioM46tSFDHnBwwKTfN05/qQLcCsKAcds4hNL0/R+QZUrQQ5bqgzPyz/x/e/Bc6/infHJ+x+8GwRnvCb5Mg/l/s+HzhqXYNTb44R76ZpH+aVxIdVdG+HMJ5POeln/9kbliLLEGg3bGyuKpcPt+HUhH1tZ7KbCfT3XxXBOFSrbCwuf8ootpUbdIizTkSeuf86i+2ptr8CCaxhYkOyJY+nQpE3aJOLzmlqmefBYT7IljUPGt+ULk/YRDcZAjy0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BS16mT6U7ksigGV4l4NLqWUfFQK5C5DsjU08zJ7G5k=;
 b=sQZwYVbIdP/EOZ3WcYfDWHy7r8HbhFCKMR17bXb1BVSRzHOfTKLkVG4+ns9p+HYmcAh6ABkLyA2kJOdJPrsONXjQ9LDoffaWznEHSA+n+XkndOsvn46MNC1wqpBFQCySSZtl2Th8WZelv2woWlAJrSAHrDXs8AmhxNWmskhTvB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAWPR04MB9718.eurprd04.prod.outlook.com (2603:10a6:102:381::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 13:34:07 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 13:34:05 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Yanan Yang <yanan.yang@nxp.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net 3/5] net: dsa: sja1105: fix multicast forwarding working only for last added mdb entry
Date:   Fri,  8 Sep 2023 16:33:50 +0300
Message-Id: <20230908133352.2007218-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908133352.2007218-1-vladimir.oltean@nxp.com>
References: <20230908133352.2007218-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAWPR04MB9718:EE_
X-MS-Office365-Filtering-Correlation-Id: ce190eb6-30a9-46cc-a759-08dbb07045d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VcKKthYc48Vd9WysnHt++/8/dU/e0w6n4OT0SoIc2rdw/B+hah45dJoB48rvGiwnR2aRBhvyt4gzcsQJWa/15No8GWp+D1x1cauxc86L43iZPhps3r2TkyFIP2ze+feovXBoH9Qx47Wt4xxXMegTnvanMYpVRPLE+6qolR4pkCUXMOf+iiiDpzhAC2Fh7CQfTco49iPh3jfaGUFHJ96vGIZ+AOZFw4pwR3ucYSOrw/kbJ1nDxur2w+PDK5pbSN7t0EpyP2gj++XpDIuDICK2+R75nQxYKeR7HxPvSJlKsSEbrGCz3OJPjYIkUFppfo+xE4QwULI+J1MoSdDgSVHZLV5D073pee341nfIUa3Mq/LD/9y9OUiTmpTe5IxpXcifTV5koZNFbwy30nhFQqo/2l5fMDmKEBMHh7R7UC9J3ySL+k6dQ/rk3ja47MmnTDj73kPbiOI/W2E+1aVbjwUXMpcpaFr0iLppzGyyGpf5s3rX8/vwAudPKdqXAeyJWPkRE5IDRtIZ+hO9PLvkeO3xRlc748Zd2xZfrPkiz5VWBIJLG1cNCa/batrYqWDQxqy/u+SWkTmt44nqttzXYQZyoIl6I+xMugiePwaQtta69JriUl2mJMjfWc2HvqBrIsTM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(39860400002)(376002)(1800799009)(186009)(451199024)(2906002)(38350700002)(38100700002)(36756003)(6506007)(41300700001)(6512007)(6486002)(52116002)(66556008)(54906003)(2616005)(66946007)(66476007)(6916009)(316002)(1076003)(86362001)(8676002)(8936002)(4326008)(6666004)(478600001)(5660300002)(26005)(83380400001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?STkOtH9TKquaOKWmZhBAvs7lE0gkQVTfIf9BBc24BK8B8ux807Tob3bvhkwV?=
 =?us-ascii?Q?/m4+7w+nKW+H2RF2fio5IjQrIT+rjwjnc0qjlFmw2d3EAcVi8KkNn9CMyqHX?=
 =?us-ascii?Q?R3IKQBW8EMyH4RruuI6c0zJsETZSvJD4oPIrOWb8NLba2AVA04UYOdmApb8+?=
 =?us-ascii?Q?xrRBMUT6goPi1kv+bcRSgOc7wYc6O0heH3k1+1X5Sm9jqUuV5MKZ9hj1PSvF?=
 =?us-ascii?Q?4FsN6V88cLDGGxM1gVvMz/+Unm7T2NkNHWxuX8v9vUoXx8yLeemDgcplMYmc?=
 =?us-ascii?Q?R2fFpKhDU+WLbZ3+o1GjDvwmKZsYIXPR3Q+UI0wbVh8O0K0aXUHJ/tKdSnfr?=
 =?us-ascii?Q?NT7YpNi0+kZA93oaX7GCKFQ0Jiy5avLqQZsIzGg30sg/7muuh35/nez5sdtY?=
 =?us-ascii?Q?/Fr3kRCw/Bwhelk3W6nTbde0puFD7ql4qjx2NPg1X1VOFhw+c15F7b0mOV6i?=
 =?us-ascii?Q?WOOydKeYF7kVai11R+5+sAfNKJS22+616JI+IePHwC69cMNKhRdKb6hvkCpM?=
 =?us-ascii?Q?SDzKf6WNkPrry72P0kw6AFoy9K3y57pBFNUr6hgHXAUQmrNTK7nBh0qzsRn5?=
 =?us-ascii?Q?34hJYCeslt1KT4kaVvR/51PYvyZ7yJnW7S5d1o9Tw19x5rZkGWkMpnwU2XxP?=
 =?us-ascii?Q?IC+cMvARi9/duUG3Z1c20Gvn+Y8Q1dDicS6cTwX8R8R1hnRWYvtSruKywgFL?=
 =?us-ascii?Q?74fu0v1zkd/v5EeG1HUbJICc5kVecvGJ8dKgcwFh1pQ0PZPzs5iQ/JtWoqvW?=
 =?us-ascii?Q?ZgMFJ8eyrcBMzsTFHPRTEu54g3ofklzhMaYKVpMNXIgbp3LeolZXBi3Se6Dp?=
 =?us-ascii?Q?EUHUIzJU+oSi6LJV51kHgj28qsTEhiWbz/hmhY1uFwsNP0mQLnaU3pfZTcHK?=
 =?us-ascii?Q?6WZC9+oUwhWPT9hadKEgcTu+r7diRErCFPAdUNVDb7vI7rO/3cvZymBIaZVb?=
 =?us-ascii?Q?cnZ551NacmLfuoMAZ+wfroKXPa5LwICq8Mt92nTdH9f/Y0iFibrAtmVZlF4G?=
 =?us-ascii?Q?/uOIMZLbaYHrNyZbjynRv+qWWe9mkFyO5gdB5B4dvHWtFA0ahQTlNFNDLMIW?=
 =?us-ascii?Q?MZ2BZqnNHrEX/56cPYO9D6lcgrXpTSGF3bUXzSCKBwEJmVKg1b3V+YQUDsam?=
 =?us-ascii?Q?8vMca6T4M3OozqcUaAFRriRK59zH53orqNf6wQtijhH7xPCFpLDINuy/EVpO?=
 =?us-ascii?Q?arTEPJaGIjFn0l9xerGVzpcLDyZ2iurr4Tv1dU+zdAvSpMVJ+EPs/Fedj+Mn?=
 =?us-ascii?Q?eckQZ3DSpViTDrdh4fiF51rArCVTQfVQV6A2uQJJEL/tyhCXf2Wr25uRe0hz?=
 =?us-ascii?Q?v0pbjJbCjAsj+A4jqqJOSPp/sLNdfbGhGhpA4EXP69XNILWQm30AmapQVNtZ?=
 =?us-ascii?Q?qplXaJHJ2jPhxAjiO8BJr69r0kXw+/ek5joQpvUBwHWaLUGc0uiarZXm2qo0?=
 =?us-ascii?Q?SEqBixDA43SIZzn3MzqHQNpENRnPpZ5Ds653Q1fBHEKalFFuVPD+vvq1Nn0F?=
 =?us-ascii?Q?oDA5j8p/F+7wvLUQ677bm0JgUqFy6pFZ9lb3imrTU6Rc2d8XZyfVNyKu7Njx?=
 =?us-ascii?Q?DMG1Wz2nHlle7wylm5XdkFbWXUM85uQ9uJBataBP8a6/8SMLKrEXL3LWDIhs?=
 =?us-ascii?Q?cw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce190eb6-30a9-46cc-a759-08dbb07045d4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 13:34:05.8635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lpA2UUCjqVXjNXetH8HGlAzbN+p5JIvyG6qR75tZm4PPktZNgykkpD2aivnOrHbL5lBjPGxI6omcBcEwWtt96g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9718
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit cited in Fixes: did 2 things: it refactored the read-back
polling from sja1105_dynamic_config_read() into a new function,
sja1105_dynamic_config_wait_complete(), and it called that from
sja1105_dynamic_config_write() too.

What is problematic is the refactoring.

The refactored code from sja1105_dynamic_config_poll_valid() works like
the previous one, but the problem is that it uses another packed_buf[]
SPI buffer, and there was code at the end of sja1105_dynamic_config_read()
which was relying on the read-back packed_buf[]:

	/* Don't dereference possibly NULL pointer - maybe caller
	 * only wanted to see whether the entry existed or not.
	 */
	if (entry)
		ops->entry_packing(packed_buf, entry, UNPACK);

After the change, the packed_buf[] that this code sees is no longer the
entry read back from hardware, but the original entry that the caller
passed to the sja1105_dynamic_config_read(), packed into this buffer.

This difference is the most notable with the SJA1105_SEARCH uses from
sja1105pqrs_fdb_add() - used for both fdb and mdb. There, we have logic
added by commit 728db843df88 ("net: dsa: sja1105: ignore the FDB entry
for unknown multicast when adding a new address") to figure out whether
the address we're trying to add matches on any existing hardware entry,
with the exception of the catch-all multicast address.

That logic was broken, because with sja1105_dynamic_config_read() not
working properly, it doesn't return us the entry read back from
hardware, but the entry that we passed to it. And, since for multicast,
a match will always exist, it will tell us that any mdb entry already
exists at index=0 L2 Address Lookup table. It is index=0 because the
caller doesn't know the index - it wants to find it out, and
sja1105_dynamic_config_read() does:

	if (index < 0) { // SJA1105_SEARCH
		/* Avoid copying a signed negative number to an u64 */
		cmd.index = 0; // <- this
		cmd.search = true;
	} else {
		cmd.index = index;
		cmd.search = false;
	}

So, to the caller of sja1105_dynamic_config_read(), the returned info
looks entirely legit, and it will add all mdb entries to FDB index 0.
There, they will always overwrite each other (not to mention,
potentially they can also overwrite a pre-existing bridge fdb entry),
and the user-visible impact will be that only the last mdb entry will be
forwarded as it should. The others won't (will be flooded or dropped,
depending on the egress flood settings).

Fixing is a bit more complicated, and involves either passing the same
packed_buf[] to sja1105_dynamic_config_wait_complete(), or moving all
the extra processing on the packed_buf[] to
sja1105_dynamic_config_wait_complete(). I've opted for the latter,
because it makes sja1105_dynamic_config_wait_complete() a bit more
self-contained.

Fixes: df405910ab9f ("net: dsa: sja1105: wait for dynamic config command completion on writes too")
Reported-by: Yanan Yang <yanan.yang@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../net/dsa/sja1105/sja1105_dynamic_config.c  | 80 +++++++++----------
 1 file changed, 37 insertions(+), 43 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_dynamic_config.c b/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
index 93d47dab8d3e..984c0e604e8d 100644
--- a/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
+++ b/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
@@ -1175,18 +1175,15 @@ const struct sja1105_dynamic_table_ops sja1110_dyn_ops[BLK_IDX_MAX_DYN] = {
 
 static int
 sja1105_dynamic_config_poll_valid(struct sja1105_private *priv,
-				  struct sja1105_dyn_cmd *cmd,
-				  const struct sja1105_dynamic_table_ops *ops)
+				  const struct sja1105_dynamic_table_ops *ops,
+				  void *entry, bool check_valident,
+				  bool check_errors)
 {
 	u8 packed_buf[SJA1105_MAX_DYN_CMD_SIZE] = {};
+	struct sja1105_dyn_cmd cmd = {};
 	int rc;
 
-	/* We don't _need_ to read the full entry, just the command area which
-	 * is a fixed SJA1105_SIZE_DYN_CMD. But our cmd_packing() API expects a
-	 * buffer that contains the full entry too. Additionally, our API
-	 * doesn't really know how many bytes into the buffer does the command
-	 * area really begin. So just read back the whole entry.
-	 */
+	/* Read back the whole entry + command structure. */
 	rc = sja1105_xfer_buf(priv, SPI_READ, ops->addr, packed_buf,
 			      ops->packed_size);
 	if (rc)
@@ -1195,11 +1192,25 @@ sja1105_dynamic_config_poll_valid(struct sja1105_private *priv,
 	/* Unpack the command structure, and return it to the caller in case it
 	 * needs to perform further checks on it (VALIDENT).
 	 */
-	memset(cmd, 0, sizeof(*cmd));
-	ops->cmd_packing(packed_buf, cmd, UNPACK);
+	ops->cmd_packing(packed_buf, &cmd, UNPACK);
 
 	/* Hardware hasn't cleared VALID => still working on it */
-	return cmd->valid ? -EAGAIN : 0;
+	if (cmd.valid)
+		return -EAGAIN;
+
+	if (check_valident && !cmd.valident && !(ops->access & OP_VALID_ANYWAY))
+		return -ENOENT;
+
+	if (check_errors && cmd.errors)
+		return -EINVAL;
+
+	/* Don't dereference possibly NULL pointer - maybe caller
+	 * only wanted to see whether the entry existed or not.
+	 */
+	if (entry)
+		ops->entry_packing(packed_buf, entry, UNPACK);
+
+	return 0;
 }
 
 /* Poll the dynamic config entry's control area until the hardware has
@@ -1208,8 +1219,9 @@ sja1105_dynamic_config_poll_valid(struct sja1105_private *priv,
  */
 static int
 sja1105_dynamic_config_wait_complete(struct sja1105_private *priv,
-				     struct sja1105_dyn_cmd *cmd,
-				     const struct sja1105_dynamic_table_ops *ops)
+				     const struct sja1105_dynamic_table_ops *ops,
+				     void *entry, bool check_valident,
+				     bool check_errors)
 {
 	int err, rc;
 
@@ -1217,7 +1229,8 @@ sja1105_dynamic_config_wait_complete(struct sja1105_private *priv,
 				rc, rc != -EAGAIN,
 				SJA1105_DYNAMIC_CONFIG_SLEEP_US,
 				SJA1105_DYNAMIC_CONFIG_TIMEOUT_US,
-				false, priv, cmd, ops);
+				false, priv, ops, entry, check_valident,
+				check_errors);
 	return err < 0 ? err : rc;
 }
 
@@ -1287,25 +1300,14 @@ int sja1105_dynamic_config_read(struct sja1105_private *priv,
 	mutex_lock(&priv->dynamic_config_lock);
 	rc = sja1105_xfer_buf(priv, SPI_WRITE, ops->addr, packed_buf,
 			      ops->packed_size);
-	if (rc < 0) {
-		mutex_unlock(&priv->dynamic_config_lock);
-		return rc;
-	}
-
-	rc = sja1105_dynamic_config_wait_complete(priv, &cmd, ops);
-	mutex_unlock(&priv->dynamic_config_lock);
 	if (rc < 0)
-		return rc;
+		goto out;
 
-	if (!cmd.valident && !(ops->access & OP_VALID_ANYWAY))
-		return -ENOENT;
+	rc = sja1105_dynamic_config_wait_complete(priv, ops, entry, true, false);
+out:
+	mutex_unlock(&priv->dynamic_config_lock);
 
-	/* Don't dereference possibly NULL pointer - maybe caller
-	 * only wanted to see whether the entry existed or not.
-	 */
-	if (entry)
-		ops->entry_packing(packed_buf, entry, UNPACK);
-	return 0;
+	return rc;
 }
 
 int sja1105_dynamic_config_write(struct sja1105_private *priv,
@@ -1357,22 +1359,14 @@ int sja1105_dynamic_config_write(struct sja1105_private *priv,
 	mutex_lock(&priv->dynamic_config_lock);
 	rc = sja1105_xfer_buf(priv, SPI_WRITE, ops->addr, packed_buf,
 			      ops->packed_size);
-	if (rc < 0) {
-		mutex_unlock(&priv->dynamic_config_lock);
-		return rc;
-	}
-
-	rc = sja1105_dynamic_config_wait_complete(priv, &cmd, ops);
-	mutex_unlock(&priv->dynamic_config_lock);
 	if (rc < 0)
-		return rc;
+		goto out;
 
-	cmd = (struct sja1105_dyn_cmd) {0};
-	ops->cmd_packing(packed_buf, &cmd, UNPACK);
-	if (cmd.errors)
-		return -EINVAL;
+	rc = sja1105_dynamic_config_wait_complete(priv, ops, NULL, false, true);
+out:
+	mutex_unlock(&priv->dynamic_config_lock);
 
-	return 0;
+	return rc;
 }
 
 static u8 sja1105_crc8_add(u8 crc, u8 byte, u8 poly)
-- 
2.34.1

