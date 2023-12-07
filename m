Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18EB80870C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjLGLvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjLGLvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:51:13 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED0D13D;
        Thu,  7 Dec 2023 03:51:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0hgflg5McTaRha/AlwLFK7wa9RXzMQLFnhTlzZtbANQSh/nA0PWmHqdSUsrdbmx4vWbMtGnIc0aw8xxhqb/ZG1+9KfX/Og5GYgjQUWAXmSLD+ML+1BBbKFpNRTiuJfrsKzKslbR8kET6T6Ja35IgowzR3E5Er6nAvva6lZDspAOtNOAwakUNAG/0la7dMda9T/fS6BNorzH8x0lxzqQdFjjwFyzZLufK5fiZPOknL9FBMT615Y7F9OIQ88COxhEL2l1lh6N4dpDIWJ95OkPdr7VfCHoLh4BXwAP7DhyXDA4kJ3dwqxxoMawpxZbI6b+qKIsVRmZeGlL1Wz4tBfm+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFinOaArdwIYeAM3WtAo6SpWlNlZf6708hGd1TSt4Uo=;
 b=lH4PvKWA0uv8aoPcyIvZmPqHyY7A0XunllI4HhK1q5gmQoA8XpVdXxy7gHAcLH1cYf764DTMserNkcyE9mBMMQS20rh+v9aWtmUupd578PkkWwta1QugabGu9dnfFV8EUnev+4IRF1griYr3VF8w8/mT6d3dTeMuYc5y1QQdd8GTPn4gg2sRB8V2jEtALo060eCe+Qo2oEFOsbMcqbXG9W4kgCYQZVriceFYU+VIZg2+40xtSnPp1ZDQXNsOcapPPDYk1QRxv7cende3UZrvpg5PDAI3w2Fdemdq6fMDNneVLlpYafLnQqDMZRdMIqgaZPuypuRH1FnHEABZDVemaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFinOaArdwIYeAM3WtAo6SpWlNlZf6708hGd1TSt4Uo=;
 b=xsJAimzXQ55SN8sYh427ZgPRUce97CBahiVF3A0U64f0jCSRRLcL7JbfP65N+z1yXYDQsCAz+I4bm+GtXbEGnf0zgzoesKUoQzORjHnzmZQvIvjIuL5kkKAhRHhW9xEaetAwLu0Gt0TIIgz3qZycxADcZVy9GjY9ZdyvyPm0Yw8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DB4PR08MB8054.eurprd08.prod.outlook.com (2603:10a6:10:389::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Thu, 7 Dec
 2023 11:51:13 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 11:51:13 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Thu, 07 Dec 2023 12:51:06 +0100
Subject: [PATCH 1/4] usb: typec: tipd: add init and reset functions to
 tipd_data
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231207-tps6598x_update-v1-1-dc21b5301d91@wolfvision.net>
References: <20231207-tps6598x_update-v1-0-dc21b5301d91@wolfvision.net>
In-Reply-To: <20231207-tps6598x_update-v1-0-dc21b5301d91@wolfvision.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701949872; l=4687;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=uuzBZoVgbfJRVw/uB3TAQ/14SQq/Je6fi5f+9uL7q9I=;
 b=Tjnkl8FGz7MALGsw64W3FrE2xGXZgF7q7SP9ZAkBDy2kYAJpHEd0nJA3D3Hg5IHX74lUZTmvO
 hJb8w+UZAuYA7i41qje4kkhIKYqNra7DcdARxT+N6cV6CT/R34rofB3
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR08CA0248.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::21) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DB4PR08MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a300ac7-1023-4cf6-6901-08dbf71acfe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: otga8B/eBym2dD76zNAxQrSx1hp1oKTkgqmuRYkEKTXry8g76ccUSL0bIKrwHU6nVluzzXndr8ngcwCdlrF+kZJbAIWQL2W5+JUYRcGi+4Ku/VgWVURW9aZnWHhvD4KVXvblpYI7aaUUwsaAPAM/22jU7eW1jgx+3kP+EAI3BeRh1yoIXtgX6A+9bBBlbd6DQ9ZQjIY+ZarmMAcjKZywu/pvFdC2Ccr9TbZvF0SLm/eWgsF474eWJcRCGpp6MLFymATqO8N01HpipY0lnZbvWtaDyqV9K1bnNd7HGIezqLOqqDAO5UmppGRIqtXpEtRlRbc49wTkSWP7rRYQ+6JnHu3GpNnI/wntj0oC52i0xCKTG+Dw29mPVqgot4ALNMbaDZEqatI5FzLbqFz2DceV80yqBHKa2p3HWaqT7ipp7IqzihUGeBC5B53Hwn3HiKWifxqVeFnbH6pF+rmm6z7Cw+j2VUBzaR5ph0I2c1sdD7cMlDE0uWQLmlgGeAc+dSAjE9LXlLCwUeUUx9yKbZquyz7lJk4nv6jVnHAWK+sZikJL21dBGNKvNrLX0d9IKQ/GzR7roA3WyTovFsdVq5MEo1sr/wCFsPS2RN39WwcOaig6sc+sQoePVnfBfjzZTat4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(136003)(396003)(376002)(366004)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(52116002)(38100700002)(5660300002)(38350700005)(2906002)(2616005)(6512007)(83380400001)(6666004)(6506007)(107886003)(26005)(110136005)(36756003)(6486002)(478600001)(41300700001)(44832011)(66946007)(66556008)(66476007)(86362001)(8936002)(4326008)(66899024)(316002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVEzTHRJQkJIb1NYbTZJcXJQVmo1WFJ1OFBmSGhpMHJzOEFmY25aL3JCVXU2?=
 =?utf-8?B?aFg5enF0Ymd4L2RqcVliZEhaS0JmckVRazFDQ091bFVPL0UwWVFNVkV0YkZo?=
 =?utf-8?B?MUI0ck5YQ0RUU25EaGs2aml4MkxlQnZ3b25tcnVONGRUN2JwOEZRUnI4dHpj?=
 =?utf-8?B?TWVsaGpuWXdVZmhGTWZiYk5Tc2hzU29ZZ2kvV0p0amRESkRUeHR0Mm1JYlZI?=
 =?utf-8?B?YmJtNWVnazFLZWNMby9USGU0RG9TUTY2Q1RGRWxoSHNRMFRFK3NjMWtGelg4?=
 =?utf-8?B?YU10cUZFQnVlL0N4Z1B4bWsybkt6OUZuaElzWGRLNS9SK055dUhodzNLa2kr?=
 =?utf-8?B?RWpTdjRYeTRPZmZHVVdnMk14b29NaXowZ3VsTjErNmtXcG5pWTJKWGgyYTky?=
 =?utf-8?B?Tm9tak55TFhxTGI3bXpGTzkxTzU0T1NTcE9OS0hVUDFXUXVYb0lvWnNDcjZh?=
 =?utf-8?B?WEZNTzNhR3dXS3FoNlo2eFNPTXJzUUpaNHV4a3RIenVvQjZvTkJBRnNVeFdV?=
 =?utf-8?B?UytvNmN0SUdjdGx4VG9XWmNTOXl4bm5xOEZ0ZXlPVkNwaUh2V3lLdnNVNU10?=
 =?utf-8?B?c0lxYmlwbXZOWUNpWnpwMUljUVV2YXBjMno3bTFBa0FzY2JoWDZXaWhuclY5?=
 =?utf-8?B?T29xR2VvS0ROelFEZEFSYnRkbW9SYzBXYlBwb3NHTDZpbmVscTNvMHJpcHdV?=
 =?utf-8?B?Ukx3bUZVYzFqbGdoYlQ1MGN6enBUTVZtT2R2SXFib2YrZjF2Y1JFbzV2b1cw?=
 =?utf-8?B?SytnV0NNT2NxWGJMeXpoVi9aWVZGdXlGK21tbVZPczZISUxsM3poa3A3bmhC?=
 =?utf-8?B?alJsUjBTVVhNcm9nQ1M5U25EeGZtTERCUHF1RDR5aHViMklpN2hhdnJ5b2RN?=
 =?utf-8?B?MlhZRnRSdzMyYk1FS3VVZlBwazU0MDgvM0l1SlluOFJ6UVJaQnJJaXdabVNy?=
 =?utf-8?B?QmNROCtlcFNGQ0pYaGJORkhFZ3A0dHlIb1F2Q3ViQXYxUDJ2Vm1jdUI3UFZD?=
 =?utf-8?B?NHJXYVJIUzgxTGMyKzNCWnVBQUU4TnFjd1grbFhHRkRmNmhTdGU5cGpFL0Jv?=
 =?utf-8?B?MVM1TTkyRUpISWtXOVU2dFlrS1hCTmNPelJZQm5yc3o3WExrTVpRb0tyNHMv?=
 =?utf-8?B?UHlkUFcyV3RibmxlY2hBdzlvalZxZWdQMzk5WUJxYXpYT0toNy9Ja3Nma1B6?=
 =?utf-8?B?azRsN3FmWGJZVlE2RUxtMWJOY3RVcWZOWFJNMFJyRkUwelZlc3U4QzY4aTk3?=
 =?utf-8?B?Nk40RmpHRHhTdFp6RXgxeXVPeWVJSW9jRm1scCtVK2pLQTAxTmQrNGk0VDZu?=
 =?utf-8?B?UVlzc2hOSXc5TmUxc3Zhb3VMTDgrZHNjS3lRU0FlTzlEUUJoVGRkRjZWbElz?=
 =?utf-8?B?TEQyeG9yQzIzN1NYRW5GU2xhek03VGpuU3JpWXM2K2tsaXl5c203K0krRHBJ?=
 =?utf-8?B?cU1aam9xdE1mMVNTQUVqb3ZSWlpXZ2lGcWhoMzlpaU5raWh1bXk1SE05djUr?=
 =?utf-8?B?aUkvVHlHaDNVOE1TcjYzUW01Sk82ZVgzSldMTVkxbWNMZENYWHZ6Z3FwR1VU?=
 =?utf-8?B?aDIrUkt1SXRSTkp1Nit1emtqWjQ4c2s4L3lpY0xLQ08wNjNnVFBwMXRLY3Q1?=
 =?utf-8?B?ZUhRQXI5cUV1UWRDTDBnRUEvZmxISmJXSVc0OTU1QWhpNU5COFNYc1Z5WnZ2?=
 =?utf-8?B?WUZCVDR0TEI5WnNEYjJaNzBoSmg2d2J4MXNqNktiN1d4Znl3VzdmSWVweVlE?=
 =?utf-8?B?YmlsR1BkUHZzOTIrQk52UEFnaExaaWpTY2l1NnZjOVBpMVUrVFFML0lMb3pH?=
 =?utf-8?B?Mk84R1pYOWVmdmRsWEFwY1N3SE1WaGhiRmkyY3BDRE54WW95Q3JoWVFFekxs?=
 =?utf-8?B?cWIyU1ZYVHE0UksxaHVCczRmT2tOelpOR0E5eCtNanp3WGFrTzdWYU92UnBa?=
 =?utf-8?B?YXpzd2ErSFVmcEMwK056UDJ5SkprUDVnMEwxaTltQ1YrUE0yUzhNZCtwL3hF?=
 =?utf-8?B?Ky9EWnRzUzJXK2Y3ZmluN05jVlo2bm9WM041ZzZsZDN1cmhITkpjUU9MNmJo?=
 =?utf-8?B?dmxPSnovYzVaL2w4d1d0MlJTYWxlamZSa25Ia1E1c2tIanRET3JoajVzOXND?=
 =?utf-8?B?ZE9YYlNUeU5TbHNLam9LcHYrWEhZUVE4ZDRiRlpLNW4xTnJ6OFlEVC8zWW9F?=
 =?utf-8?Q?wozM1ivF+5hOWVbTmv1+O9s=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a300ac7-1023-4cf6-6901-08dbf71acfe6
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 11:51:13.3313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HgGgmNZ5atsQ2e0wanZcB/6zCkKs9kdxCbu1+xj8vTQab+zDdZgl5lApsG5ma0pjCSMM+rbgFfLeugOuX4CDDizG8TQ+2TCagpkxjpBjPWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8054
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation includes a number of special cases for the
tps25750. Nevertheless, init and reset functions can be generalized by
adding function pointers to the tipd_data structure in order to offer
that functionality to other parts without additional conditional
clauses.

Some functionality like the cold reset request (GAID) is shared by the
tps25750 and the tps6598x, so they can use the same reset function.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/usb/typec/tipd/core.c | 45 +++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 806ef68273ca..f0c4cd571a37 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -115,6 +115,8 @@ struct tipd_data {
 	void (*trace_power_status)(u16 status);
 	void (*trace_status)(u32 status);
 	int (*apply_patch)(struct tps6598x *tps);
+	int (*init)(struct tps6598x *tps);
+	int (*reset)(struct tps6598x *tps);
 };
 
 struct tps6598x {
@@ -1106,6 +1108,11 @@ static int tps25750_apply_patch(struct tps6598x *tps)
 	return 0;
 };
 
+static int cd321x_init(struct tps6598x *tps)
+{
+	return 0;
+}
+
 static int tps25750_init(struct tps6598x *tps)
 {
 	int ret;
@@ -1124,6 +1131,21 @@ static int tps25750_init(struct tps6598x *tps)
 	return 0;
 }
 
+static int tps6598x_init(struct tps6598x *tps)
+{
+	return 0;
+}
+
+static int cd321x_reset(struct tps6598x *tps)
+{
+	return 0;
+}
+
+static int tps6598x_reset(struct tps6598x *tps)
+{
+	return tps6598x_exec_cmd_tmo(tps, "GAID", 0, NULL, 0, NULL, 2000, 0);
+}
+
 static int
 tps25750_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
 {
@@ -1187,7 +1209,6 @@ static int tps6598x_probe(struct i2c_client *client)
 	u32 vid;
 	int ret;
 	u64 mask1;
-	bool is_tps25750;
 
 	tps = devm_kzalloc(&client->dev, sizeof(*tps), GFP_KERNEL);
 	if (!tps)
@@ -1207,8 +1228,7 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (IS_ERR(tps->regmap))
 		return PTR_ERR(tps->regmap);
 
-	is_tps25750 = device_is_compatible(tps->dev, "ti,tps25750");
-	if (!is_tps25750) {
+	if (!device_is_compatible(tps->dev, "ti,tps25750")) {
 		ret = tps6598x_read32(tps, TPS_REG_VID, &vid);
 		if (ret < 0 || !vid)
 			return -ENODEV;
@@ -1251,8 +1271,8 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	if (is_tps25750 && ret == TPS_MODE_PTCH) {
-		ret = tps25750_init(tps);
+	if (ret == TPS_MODE_PTCH) {
+		ret = tps->data->init(tps);
 		if (ret)
 			return ret;
 	}
@@ -1340,8 +1360,8 @@ static int tps6598x_probe(struct i2c_client *client)
 	tps6598x_write64(tps, TPS_REG_INT_MASK1, 0);
 err_reset_controller:
 	/* Reset PD controller to remove any applied patch */
-	if (is_tps25750)
-		tps6598x_exec_cmd_tmo(tps, "GAID", 0, NULL, 0, NULL, 2000, 0);
+	tps->data->reset(tps);
+
 	return ret;
 }
 
@@ -1358,8 +1378,7 @@ static void tps6598x_remove(struct i2c_client *client)
 	usb_role_switch_put(tps->role_sw);
 
 	/* Reset PD controller to remove any applied patch */
-	if (device_is_compatible(tps->dev, "ti,tps25750"))
-		tps6598x_exec_cmd_tmo(tps, "GAID", 0, NULL, 0, NULL, 2000, 0);
+	tps->data->reset(tps);
 
 	if (tps->reset)
 		gpiod_set_value_cansleep(tps->reset, 1);
@@ -1393,7 +1412,7 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	if (device_is_compatible(tps->dev, "ti,tps25750") && ret == TPS_MODE_PTCH) {
+	if (ret == TPS_MODE_PTCH) {
 		ret = tps25750_init(tps);
 		if (ret)
 			return ret;
@@ -1423,6 +1442,8 @@ static const struct tipd_data cd321x_data = {
 	.register_port = tps6598x_register_port,
 	.trace_power_status = trace_tps6598x_power_status,
 	.trace_status = trace_tps6598x_status,
+	.init = cd321x_init,
+	.reset = cd321x_reset,
 };
 
 static const struct tipd_data tps6598x_data = {
@@ -1430,6 +1451,8 @@ static const struct tipd_data tps6598x_data = {
 	.register_port = tps6598x_register_port,
 	.trace_power_status = trace_tps6598x_power_status,
 	.trace_status = trace_tps6598x_status,
+	.init = tps6598x_init,
+	.reset = tps6598x_reset,
 };
 
 static const struct tipd_data tps25750_data = {
@@ -1438,6 +1461,8 @@ static const struct tipd_data tps25750_data = {
 	.trace_power_status = trace_tps25750_power_status,
 	.trace_status = trace_tps25750_status,
 	.apply_patch = tps25750_apply_patch,
+	.init = tps25750_init,
+	.reset = tps6598x_reset,
 };
 
 static const struct of_device_id tps6598x_of_match[] = {

-- 
2.39.2

