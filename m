Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B9E772B1C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjHGQhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjHGQhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:37:08 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E2F1FD2;
        Mon,  7 Aug 2023 09:36:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAPUv2PHMAgqF9tSxOet4tPR2qGlzZSCVoYXUR0rIMuyg3InUH6BxZg42ZqK2H4hLG+/XcScMF5LQj2B0LeyWCuQO2isRDnwX/SdnZCK4r8Pny9MWePtJtwBUaPgZQkNbmsQTP9ppl7pZDzZRAWesD06IW+GB+39eICnksyGkc/iZUySoEeD12Ko5S2HDB8uTaDG2siECnZNGyGlbQ2bi2yOWp/u839FDEmSJbdEgA+/svdCe9vwDmGZdhc3aYOn4MGzFjXQioJzZklbcjE9iKLNgYkp9UuEwGXFa48JvTtB27N/E9gNf8X1kC+w863UKM2F3ILMk4xoeq0ATL5KzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yncJlmf0iV+XzHh/TEFnFWL8+qNScScuQKlA7PUqiSI=;
 b=X/iG9NMyI6evm8xCnTJpfHedr5M/u6Y0y6xvnC8Uhr03OSMPNXqxnb/rsHqmFxL4lF6oAawSYCu/I1UDqhYfED9GDKwM8Y9BVRPg1eq/zKVMppb7gH41bzCyZNjuMs1MfUrTEgMGWqTT5APKqshbsQbIl29DZV1dIMneQjG3eT7dfaWT+vR2WoF9Vz7i2fEeGxbdIBoLnxrVTaGnYLG785cq+ryqJzPyC2Vb1Cs5g3mWuTlPNj8hBLPRknM/CRc29GNEJyc3ycMuQhgw2PcXnlsFnDN+Wltq4MoOXTHoD+7zdquYAVRD8wUA2whGybAN2eCQHj3FgtH/C1V+X9cbfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yncJlmf0iV+XzHh/TEFnFWL8+qNScScuQKlA7PUqiSI=;
 b=YwXZ/QdKjAEX5CfU8ROnFReseIpsqQlybLL/bieFvApRH5QXRt288oMQk0kfgpebkbzVGeKFZAIFJaY8YeJpgSERxnIGZG1db5v1pEfdA7hLvBYtPGKqaewqnJVdBUwk3Xz/b63osVFE3IR85k/QSOXJwub2soqANV166z37Iu6BP3W0EqNVOEmQImk5zMfnY0VKkdr6UpKbUeIatkVn0mZ1JNfsdHkzHPzurHuoNvoSd9Djah1vHmjaJFwXkvOUa6OBDS3ScVTyExnuqWWMqJQZ/z82Nho4CgFcVR5Fkya14hTkGtUHtoJb1aGg5OK+KUCeGjGvMULmzTWJbjTzcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CY8PR12MB8194.namprd12.prod.outlook.com (2603:10b6:930:76::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Mon, 7 Aug
 2023 16:36:27 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::bd1:3314:4416:227f]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::bd1:3314:4416:227f%4]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 16:36:30 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH 2/3] HID: nvidia-shield: Add battery support for Thunderstrike
Date:   Mon,  7 Aug 2023 09:36:19 -0700
Message-Id: <20230807163620.16855-2-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807163620.16855-1-rrameshbabu@nvidia.com>
References: <20230807163620.16855-1-rrameshbabu@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0101.namprd05.prod.outlook.com
 (2603:10b6:a03:334::16) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CY8PR12MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: 810861ae-1ba2-4312-9831-08db976473f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hbfiep7+wIsaxxBC3AgTQ4WyQBFnzj0CZFPGBeYfg0MH6QTI6zL5x9qceIpuvae91DaXC65fm7Bote3J0wfCQd0zVCinN96Z0nsy4UZPDiMkpvMM1CNbMDm5bscBf5U6wl29Km8BMYjvmW8/KooLGv5230tmf9TggyQFODWV98KiVhPV8YdaeEsZLK3vV42j4lhKZmvmWZdpHwO9gXWgLh2bnCkAkCE97AATeeg9JhyphvtOBvmE5oLOjQBRAfuaz/XZ/D9yb6nigwrwSjsoJMM9i5xViYLO0FxQFztwjm0v+7ksIrxMb3NF5lINaen8QsJ5fFUA+ahFOq4mk4PznPWKOk4W76eeiNBgjPD9lT1pXuqTJgx6bBhYjHBRZYnsONr3W7LCpc3UqkY1tyMHbVzspwjgQriT9DhcTwBAYyvU6N/+oJAEeT9hHXgnxdi2aXjWab6ZY4y/68EOaSnAx+JwFivwuIsP9JsvwZFOGeyyga5Xzr114OCpucYVJleldwUCLDJF7zlfNuzDz3gQgYDse7JmyyBqmXmMMsc0JAn9zJ3dp+CQBlmi720bS2G9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(186006)(1800799003)(451199021)(4326008)(316002)(66476007)(66556008)(66946007)(38100700002)(36756003)(6666004)(6512007)(6486002)(107886003)(2616005)(83380400001)(66574015)(1076003)(26005)(6506007)(30864003)(2906002)(86362001)(478600001)(110136005)(8676002)(8936002)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXpDeFBqSCtiNStIeEkvL3JCbEg5QWNsRWpud1hNZjIwQ1Nqbi9XVEhwZ1RY?=
 =?utf-8?B?ZkVXQ0pzNStYR3FiaURQNlphQlhSQ2ZzbDhHaGd5N1Y3cll1bXRQKzFVYmtr?=
 =?utf-8?B?dHhqRWU3M0tYRUpXZGkySDZBTkdOTFlib2szU25HbDR1N0tCSU5ycVJabHRt?=
 =?utf-8?B?bXFuUzJJUXU3dzBUNGRqNzZHREZlTnp3VG1xclVlRC93UEdOZUlyejBvL1Fo?=
 =?utf-8?B?dmRkcEJzQWtTQXMzRkozejRJSFFQNnFxMXRrT1dOWFVsamd0eWhFY0JPVzVk?=
 =?utf-8?B?VkdWUDVkeFRQNDB3aitqVUQrUm9FOFB1MmlnRDhYMm5YSy8wK1hqV1dpQTM0?=
 =?utf-8?B?WlhxYy9sYUZFYVFMNmMzdUFtaWxOUDFIY09FSGhWRDZvcHdhQmNDTmY2NUlU?=
 =?utf-8?B?enU5dGoyYlNQbmd5UHpoZC9uNkFKaWsyWmVsWHovOXVaSmI5U25zaWVVa3Ba?=
 =?utf-8?B?RlFYYjFVL3RoSXlDTElEQ0lPUUF2cE1UL2dDNUpqNnQ0dlF2NEFlSklKR01r?=
 =?utf-8?B?aFZ2cndaeUJSdVQ2dFZCdzBOeGZ1Wm1mN1VnRW9FOHlOMWRmQi9xNkpWZXhZ?=
 =?utf-8?B?bXR6dVQrb3AvRTl1QlJMd0tVM1U4ZnZwZHBXZ2dLOEcyQ3RSVDUyeHMvOUJX?=
 =?utf-8?B?bytaN3dRcEsrVS85WlUwZlJtZ1lCSjRwZndwZld5OVZHMTNySlNmQVBZZU5z?=
 =?utf-8?B?V2ZVRTFrQ1htUnV5MUhMNGRmaEQ2b1lDNUdsUndJcW1mTjRyVE1JZzJXTkFC?=
 =?utf-8?B?VUVRdjV2SUV1a1JCSDRUZkZKamp4RGt4QmVRb3FLekowaUpqa3pERXJvOVVM?=
 =?utf-8?B?U2VKcVIrL1RseUE2MkRWL0g1UGdhR1c5ZUg5TFdzTVRSYjVkQTRoak9ISzBt?=
 =?utf-8?B?b1dPcXB1OUVjekpDM2o2ZWNuVXg1NThMV05HZjVwWnlmYTdsWlQ2S3RXWVNK?=
 =?utf-8?B?dFZ1bmVzbTJ5KzRQYmVpT2d6SEVtYm45ZG1LY1pPTUxEeE5rbnBSMHlIT0dE?=
 =?utf-8?B?b0pTNlIrRllIei9GbS8vN29idmdsL2Q3KzYyZTJTa0Y5YVZ6Z1JFQUIxWDRF?=
 =?utf-8?B?WFh3UHYrR3FVOWJQMU50b1JzTzFpdDloVEtCSFBMMThOanhDaTYvbEVMWGk4?=
 =?utf-8?B?Wlk0L1RnNm5GOUk5UnZueWVDYURSWlh0aUZDb0dwVmpCQUlDMzFuaEJKKzIr?=
 =?utf-8?B?Y24wSUxkS2lHTkY3N3JRRlBoVUsyUEVZQ3B0VkRxOWd6UlhGRHVubUg1MC84?=
 =?utf-8?B?QnNpWXFSN3pHSWFZS1N4aGJxUVVFMkJpc1U5MFR6L2o4REEyYzByVnRyWUZ1?=
 =?utf-8?B?NU1ZTURhVDJIZkFsUmZBS3lxSHpzUFVra0JSN1FDQlQ0bmxMR3ZvWlcrSlVk?=
 =?utf-8?B?eFRkSm1ncWplbWRzMk1ST0FZbWU3YlQvMmNacXAvK05WcUczNXVXWlR4azVr?=
 =?utf-8?B?c0NjUEZnMng4YkRVdnZDTHdBR3R3QVNZYU1hK2o5OUxaZzd5U2IrdDJ1YnZZ?=
 =?utf-8?B?L2g0TlZEbnBHQ0RLdDNMWnFsKzNWdzRINUJ5MkRQN0xBK2g3dmFlREZvMGQz?=
 =?utf-8?B?bDZuY1VOZDkycTJIV0RSQktqakJTd2o1RnA1bUVPa0JBemJUcHI5aWRZYnZH?=
 =?utf-8?B?QnRTNVVwNisrQnYvZ3Fkb1pWa2pYc0J5RW90cU9DT3lYanpaTGFrdzVpY3Zz?=
 =?utf-8?B?MnB2UFJCNHdwUnl2WCtOVWJCS1ZrSHJmanJDbzVhUWFUcXBCVXZTUERQQmVX?=
 =?utf-8?B?TWJQcm9CYlNvdlNJMm8wMGw2M2FnUDU5YnhBTk9jUis2TE04Smc1eTlCbE0v?=
 =?utf-8?B?WTJFTGhKeVFuSEhlZlIvZHZFcWhRNnNYWnRDbzdlUnRMUTVKQWMwNTdONTRo?=
 =?utf-8?B?Wmc3Qzc4TnkxSElUV3hXamhyeHlRL3B2YlBaN1pDOTBKejE4YVBQbzh1eU5l?=
 =?utf-8?B?cU1RSk4zMkVydmVFc0RjUlV0bUFlN0VZcG1XZ0t5b3ZqWkFjSDRBcU1MaFBp?=
 =?utf-8?B?emVaeUxyWTZWUWw4MDRTYlFwclorV2xNTFpoQ2FEZkoxTEdUYUpoUlRzMTA1?=
 =?utf-8?B?MXVDMndFRFZURGlSeUl3QVZ1UVowN2dXV2pQS25Sa2Q2YTAzMWF1cFJxV1Bq?=
 =?utf-8?B?RW5lVTBJUDZCd2F0K1R5QXRaOHI1QmtkTUtaM0g0eGpzT29JRGgyY0Z0MmFR?=
 =?utf-8?B?NUE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 810861ae-1ba2-4312-9831-08db976473f2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 16:36:30.2244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYpaqp7JlNRmO1bVTmNuB5QVLO+JcThyWEBwu9b4PoNygyEutD42mZWBkZdfysoASoISv6M47pnzmuBHtrU/vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8194
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use power supply API to expose battery information about connected
Thunderstrike controllers to the system. Provide information on battery
capacity, charge status, charger type, voltage, and temperature.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---
 drivers/hid/hid-nvidia-shield.c | 418 ++++++++++++++++++++++++++++++--
 1 file changed, 401 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/hid-nvidia-shield.c b/drivers/hid/hid-nvidia-shield.c
index 4e183650c447..1612de3ef4c5 100644
--- a/drivers/hid/hid-nvidia-shield.c
+++ b/drivers/hid/hid-nvidia-shield.c
@@ -6,11 +6,15 @@
  */
 
 #include <linux/hid.h>
+#include <linux/idr.h>
 #include <linux/input-event-codes.h>
 #include <linux/input.h>
+#include <linux/jiffies.h>
 #include <linux/leds.h>
 #include <linux/module.h>
+#include <linux/power_supply.h>
 #include <linux/spinlock.h>
+#include <linux/timer.h>
 #include <linux/workqueue.h>
 
 #include "hid-ids.h"
@@ -30,6 +34,8 @@ enum {
 enum {
 	SHIELD_FW_VERSION_INITIALIZED = 0,
 	SHIELD_BOARD_INFO_INITIALIZED,
+	SHIELD_BATTERY_STATS_INITIALIZED,
+	SHIELD_CHARGER_STATE_INITIALIZED,
 };
 
 enum {
@@ -37,6 +43,7 @@ enum {
 	THUNDERSTRIKE_BOARD_INFO_UPDATE,
 	THUNDERSTRIKE_HAPTICS_UPDATE,
 	THUNDERSTRIKE_LED_UPDATE,
+	THUNDERSTRIKE_POWER_SUPPLY_STATS_UPDATE,
 };
 
 enum {
@@ -48,10 +55,46 @@ enum {
 enum {
 	THUNDERSTRIKE_HOSTCMD_ID_FW_VERSION = 1,
 	THUNDERSTRIKE_HOSTCMD_ID_LED = 6,
+	THUNDERSTRIKE_HOSTCMD_ID_BATTERY,
 	THUNDERSTRIKE_HOSTCMD_ID_BOARD_INFO = 16,
 	THUNDERSTRIKE_HOSTCMD_ID_USB_INIT = 53,
 	THUNDERSTRIKE_HOSTCMD_ID_HAPTICS = 57,
-	THUNDERSTRIKE_HOSTCMD_ID_BLUETOOTH_INIT = 58,
+	THUNDERSTRIKE_HOSTCMD_ID_CHARGER,
+};
+
+struct power_supply_dev {
+	struct power_supply *psy;
+	struct power_supply_desc desc;
+};
+
+struct thunderstrike_psy_prop_values {
+	int voltage_min;
+	int voltage_now;
+	int voltage_avg;
+	int voltage_boot;
+	int capacity;
+	int status;
+	int charge_type;
+	int temp;
+};
+
+static const enum power_supply_property thunderstrike_battery_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_AVG,
+	POWER_SUPPLY_PROP_VOLTAGE_BOOT,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_SCOPE,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_TEMP_MIN,
+	POWER_SUPPLY_PROP_TEMP_MAX,
+	POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
+	POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
 };
 
 enum thunderstrike_led_state {
@@ -60,6 +103,38 @@ enum thunderstrike_led_state {
 } __packed;
 static_assert(sizeof(enum thunderstrike_led_state) == 1);
 
+struct thunderstrike_hostcmd_battery {
+	__le16 voltage_avg;
+	u8 reserved_at_10;
+	__le16 thermistor;
+	__le16 voltage_min;
+	__le16 voltage_boot;
+	__le16 voltage_now;
+	u8 capacity;
+} __packed;
+
+enum thunderstrike_charger_type {
+	THUNDERSTRIKE_CHARGER_TYPE_NONE = 0,
+	THUNDERSTRIKE_CHARGER_TYPE_TRICKLE,
+	THUNDERSTRIKE_CHARGER_TYPE_NORMAL,
+} __packed;
+static_assert(sizeof(enum thunderstrike_charger_type) == 1);
+
+enum thunderstrike_charger_state {
+	THUNDERSTRIKE_CHARGER_STATE_UNKNOWN = 0,
+	THUNDERSTRIKE_CHARGER_STATE_DISABLED,
+	THUNDERSTRIKE_CHARGER_STATE_CHARGING,
+	THUNDERSTRIKE_CHARGER_STATE_FULL,
+	THUNDERSTRIKE_CHARGER_STATE_FAILED = 8,
+} __packed;
+static_assert(sizeof(enum thunderstrike_charger_state) == 1);
+
+struct thunderstrike_hostcmd_charger {
+	u8 connected;
+	enum thunderstrike_charger_type type;
+	enum thunderstrike_charger_state state;
+} __packed;
+
 struct thunderstrike_hostcmd_board_info {
 	__le16 revision;
 	__le16 serial[7];
@@ -80,6 +155,8 @@ struct thunderstrike_hostcmd_resp_report {
 		struct thunderstrike_hostcmd_haptics motors;
 		__le16 fw_version;
 		enum thunderstrike_led_state led_state;
+		struct thunderstrike_hostcmd_battery battery;
+		struct thunderstrike_hostcmd_charger charger;
 		u8 payload[30];
 	} __packed;
 } __packed;
@@ -109,6 +186,7 @@ static_assert(sizeof(struct thunderstrike_hostcmd_req_report) ==
 /* Common struct for shield accessories. */
 struct shield_device {
 	struct hid_device *hdev;
+	struct power_supply_dev battery_dev;
 
 	unsigned long initialized_flags;
 	const char *codename;
@@ -119,9 +197,17 @@ struct shield_device {
 	} board_info;
 };
 
+/*
+ * Non-trivial to uniquely identify Thunderstrike controllers at initialization
+ * time. Use an ID allocator to help with this.
+ */
+static DEFINE_IDA(thunderstrike_ida);
+
 struct thunderstrike {
 	struct shield_device base;
 
+	int id;
+
 	/* Sub-devices */
 	struct input_dev *haptics_dev;
 	struct led_classdev led_dev;
@@ -133,6 +219,9 @@ struct thunderstrike {
 	spinlock_t haptics_update_lock;
 	u8 led_state : 1;
 	enum thunderstrike_led_state led_value;
+	struct thunderstrike_psy_prop_values psy_stats;
+	spinlock_t psy_stats_lock;
+	struct timer_list psy_stats_timer;
 	struct work_struct hostcmd_req_work;
 };
 
@@ -247,6 +336,16 @@ static void thunderstrike_hostcmd_req_work_handler(struct work_struct *work)
 		thunderstrike_send_hostcmd_request(ts);
 	}
 
+	if (test_and_clear_bit(THUNDERSTRIKE_POWER_SUPPLY_STATS_UPDATE, &ts->update_flags)) {
+		thunderstrike_hostcmd_req_report_init(
+			report, THUNDERSTRIKE_HOSTCMD_ID_BATTERY);
+		thunderstrike_send_hostcmd_request(ts);
+
+		thunderstrike_hostcmd_req_report_init(
+			report, THUNDERSTRIKE_HOSTCMD_ID_CHARGER);
+		thunderstrike_send_hostcmd_request(ts);
+	}
+
 	if (test_and_clear_bit(THUNDERSTRIKE_BOARD_INFO_UPDATE, &ts->update_flags)) {
 		thunderstrike_hostcmd_req_report_init(
 			report, THUNDERSTRIKE_HOSTCMD_ID_BOARD_INFO);
@@ -352,6 +451,93 @@ static void thunderstrike_led_set_brightness(struct led_classdev *led,
 	schedule_work(&ts->hostcmd_req_work);
 }
 
+static int thunderstrike_battery_get_property(struct power_supply *psy,
+					      enum power_supply_property psp,
+					      union power_supply_propval *val)
+{
+	struct shield_device *shield_dev = power_supply_get_drvdata(psy);
+	struct thunderstrike_psy_prop_values prop_values;
+	struct thunderstrike *ts;
+	int ret = 0;
+
+	ts = container_of(shield_dev, struct thunderstrike, base);
+	spin_lock(&ts->psy_stats_lock);
+	prop_values = ts->psy_stats;
+	spin_unlock(&ts->psy_stats_lock);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		val->intval = prop_values.status;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		val->intval = prop_values.charge_type;
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = 1;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		val->intval = prop_values.voltage_min;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
+		val->intval = 2900000; /* 2.9 V */
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
+		val->intval = 2200000; /* 2.2 V */
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = prop_values.voltage_now;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
+		val->intval = prop_values.voltage_avg;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_BOOT:
+		val->intval = prop_values.voltage_boot;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = prop_values.capacity;
+		break;
+	case POWER_SUPPLY_PROP_SCOPE:
+		val->intval = POWER_SUPPLY_SCOPE_DEVICE;
+		break;
+	case POWER_SUPPLY_PROP_TEMP:
+		val->intval = prop_values.temp;
+		break;
+	case POWER_SUPPLY_PROP_TEMP_MIN:
+		val->intval = 0; /* 0 C */
+		break;
+	case POWER_SUPPLY_PROP_TEMP_MAX:
+		val->intval = 400; /* 40 C */
+		break;
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
+		val->intval = 15; /* 1.5 C */
+		break;
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
+		val->intval = 380; /* 38 C */
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static inline void thunderstrike_request_psy_stats(struct thunderstrike *ts)
+{
+	set_bit(THUNDERSTRIKE_POWER_SUPPLY_STATS_UPDATE, &ts->update_flags);
+	schedule_work(&ts->hostcmd_req_work);
+}
+
+static void thunderstrike_psy_stats_timer_handler(struct timer_list *timer)
+{
+	struct thunderstrike *ts =
+		container_of(timer, struct thunderstrike, psy_stats_timer);
+
+	thunderstrike_request_psy_stats(ts);
+	/* Query battery statistics from device every five minutes */
+	mod_timer(timer, jiffies + 300 * HZ);
+}
+
 static void
 thunderstrike_parse_fw_version_payload(struct shield_device *shield_dev,
 				       __le16 fw_version)
@@ -416,13 +602,138 @@ thunderstrike_parse_led_payload(struct shield_device *shield_dev,
 	hid_dbg(shield_dev->hdev, "Thunderstrike led HOSTCMD response, 0x%02X\n", led_state);
 }
 
+static void thunderstrike_parse_battery_payload(
+	struct shield_device *shield_dev,
+	struct thunderstrike_hostcmd_battery *battery)
+{
+	struct thunderstrike *ts = container_of(shield_dev, struct thunderstrike, base);
+	u16 hostcmd_voltage_boot = le16_to_cpu(battery->voltage_boot);
+	u16 hostcmd_voltage_avg = le16_to_cpu(battery->voltage_avg);
+	u16 hostcmd_voltage_min = le16_to_cpu(battery->voltage_min);
+	u16 hostcmd_voltage_now = le16_to_cpu(battery->voltage_now);
+	u16 hostcmd_thermistor = le16_to_cpu(battery->thermistor);
+	int voltage_boot, voltage_avg, voltage_min, voltage_now;
+	struct hid_device *hdev = shield_dev->hdev;
+	u8 capacity = battery->capacity;
+	int temp;
+
+	/* Convert thunderstrike device values to µV and tenths of degree Celsius */
+	voltage_boot = hostcmd_voltage_boot * 1000;
+	voltage_avg = hostcmd_voltage_avg * 1000;
+	voltage_min = hostcmd_voltage_min * 1000;
+	voltage_now = hostcmd_voltage_now * 1000;
+	temp = (1378 - (int)hostcmd_thermistor) * 10 / 19;
+
+	/* Copy converted values */
+	spin_lock(&ts->psy_stats_lock);
+	ts->psy_stats.voltage_boot = voltage_boot;
+	ts->psy_stats.voltage_avg = voltage_avg;
+	ts->psy_stats.voltage_min = voltage_min;
+	ts->psy_stats.voltage_now = voltage_now;
+	ts->psy_stats.capacity = capacity;
+	ts->psy_stats.temp = temp;
+	spin_unlock(&ts->psy_stats_lock);
+
+	set_bit(SHIELD_BATTERY_STATS_INITIALIZED, &shield_dev->initialized_flags);
+
+	hid_dbg(hdev,
+		"Thunderstrike battery HOSTCMD response, voltage_avg: %u voltage_now: %u\n",
+		hostcmd_voltage_avg, hostcmd_voltage_now);
+	hid_dbg(hdev,
+		"Thunderstrike battery HOSTCMD response, voltage_boot: %u voltage_min: %u\n",
+		hostcmd_voltage_boot, hostcmd_voltage_min);
+	hid_dbg(hdev,
+		"Thunderstrike battery HOSTCMD response, thermistor: %u\n",
+		hostcmd_thermistor);
+	hid_dbg(hdev,
+		"Thunderstrike battery HOSTCMD response, capacity: %u%%\n",
+		capacity);
+}
+
+static void thunderstrike_parse_charger_payload(
+	struct shield_device *shield_dev,
+	struct thunderstrike_hostcmd_charger *charger)
+{
+	struct thunderstrike *ts = container_of(shield_dev, struct thunderstrike, base);
+	int charge_type = POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
+	struct hid_device *hdev = shield_dev->hdev;
+	int status = POWER_SUPPLY_STATUS_UNKNOWN;
+
+	switch (charger->type) {
+	case THUNDERSTRIKE_CHARGER_TYPE_NONE:
+		charge_type = POWER_SUPPLY_CHARGE_TYPE_NONE;
+		break;
+	case THUNDERSTRIKE_CHARGER_TYPE_TRICKLE:
+		charge_type = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
+		break;
+	case THUNDERSTRIKE_CHARGER_TYPE_NORMAL:
+		charge_type = POWER_SUPPLY_CHARGE_TYPE_STANDARD;
+		break;
+	default:
+		hid_warn(hdev, "Unhandled Thunderstrike charger HOSTCMD type, %u\n",
+			 charger->type);
+		break;
+	}
+
+	switch (charger->state) {
+	case THUNDERSTRIKE_CHARGER_STATE_UNKNOWN:
+		status = POWER_SUPPLY_STATUS_UNKNOWN;
+		break;
+	case THUNDERSTRIKE_CHARGER_STATE_DISABLED:
+		/* Indicates charger is disconnected */
+		break;
+	case THUNDERSTRIKE_CHARGER_STATE_CHARGING:
+		status = POWER_SUPPLY_STATUS_CHARGING;
+		break;
+	case THUNDERSTRIKE_CHARGER_STATE_FULL:
+		status = POWER_SUPPLY_STATUS_FULL;
+		break;
+	case THUNDERSTRIKE_CHARGER_STATE_FAILED:
+		status = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		hid_err(hdev, "Thunderstrike device failed to charge\n");
+		break;
+	default:
+		hid_warn(hdev, "Unhandled Thunderstrike charger HOSTCMD state, %u\n",
+			 charger->state);
+		break;
+	}
+
+	if (!charger->connected)
+		status = POWER_SUPPLY_STATUS_DISCHARGING;
+
+	spin_lock(&ts->psy_stats_lock);
+	ts->psy_stats.charge_type = charge_type;
+	ts->psy_stats.status = status;
+	spin_unlock(&ts->psy_stats_lock);
+
+	set_bit(SHIELD_CHARGER_STATE_INITIALIZED, &shield_dev->initialized_flags);
+
+	hid_dbg(hdev,
+		"Thunderstrike charger HOSTCMD response, connected: %u, type: %u, state: %u\n",
+		charger->connected, charger->type, charger->state);
+}
+
+static inline void thunderstrike_device_init_info(struct shield_device *shield_dev)
+{
+	struct thunderstrike *ts =
+		container_of(shield_dev, struct thunderstrike, base);
+
+	if (!test_bit(SHIELD_FW_VERSION_INITIALIZED, &shield_dev->initialized_flags))
+		thunderstrike_request_firmware_version(ts);
+
+	if (!test_bit(SHIELD_BOARD_INFO_INITIALIZED, &shield_dev->initialized_flags))
+		thunderstrike_request_board_info(ts);
+
+	if (!test_bit(SHIELD_BATTERY_STATS_INITIALIZED, &shield_dev->initialized_flags) ||
+	    !test_bit(SHIELD_CHARGER_STATE_INITIALIZED, &shield_dev->initialized_flags))
+		thunderstrike_psy_stats_timer_handler(&ts->psy_stats_timer);
+}
+
 static int thunderstrike_parse_report(struct shield_device *shield_dev,
 				      struct hid_report *report, u8 *data,
 				      int size)
 {
 	struct thunderstrike_hostcmd_resp_report *hostcmd_resp_report;
-	struct thunderstrike *ts =
-		container_of(shield_dev, struct thunderstrike, base);
 	struct hid_device *hdev = shield_dev->hdev;
 
 	switch (report->id) {
@@ -445,6 +756,10 @@ static int thunderstrike_parse_report(struct shield_device *shield_dev,
 		case THUNDERSTRIKE_HOSTCMD_ID_LED:
 			thunderstrike_parse_led_payload(shield_dev, hostcmd_resp_report->led_state);
 			break;
+		case THUNDERSTRIKE_HOSTCMD_ID_BATTERY:
+			thunderstrike_parse_battery_payload(shield_dev,
+							    &hostcmd_resp_report->battery);
+			break;
 		case THUNDERSTRIKE_HOSTCMD_ID_BOARD_INFO:
 			thunderstrike_parse_board_info_payload(
 				shield_dev, &hostcmd_resp_report->board_info);
@@ -453,14 +768,17 @@ static int thunderstrike_parse_report(struct shield_device *shield_dev,
 			thunderstrike_parse_haptics_payload(
 				shield_dev, &hostcmd_resp_report->motors);
 			break;
-
 		case THUNDERSTRIKE_HOSTCMD_ID_USB_INIT:
-		case THUNDERSTRIKE_HOSTCMD_ID_BLUETOOTH_INIT:
 			/* May block HOSTCMD requests till received initially */
-			thunderstrike_request_firmware_version(ts);
-			thunderstrike_request_board_info(ts);
-			/* Only HOSTCMD that can be triggered without a request */
-			return 0;
+			thunderstrike_device_init_info(shield_dev);
+			break;
+		case THUNDERSTRIKE_HOSTCMD_ID_CHARGER:
+			/* May block HOSTCMD requests till received initially */
+			thunderstrike_device_init_info(shield_dev);
+
+			thunderstrike_parse_charger_payload(
+				shield_dev, &hostcmd_resp_report->charger);
+			break;
 		default:
 			hid_warn(hdev,
 				 "Unhandled Thunderstrike HOSTCMD id %d\n",
@@ -489,6 +807,50 @@ static inline int thunderstrike_led_create(struct thunderstrike *ts)
 	return led_classdev_register(&ts->base.hdev->dev, led);
 }
 
+static inline int thunderstrike_psy_create(struct shield_device *shield_dev)
+{
+	struct thunderstrike *ts = container_of(shield_dev, struct thunderstrike, base);
+	struct power_supply_config psy_cfg = { .drv_data = shield_dev, };
+	struct hid_device *hdev = shield_dev->hdev;
+	int ret;
+
+	/*
+	 * Set an initial capacity and temperature value to avoid prematurely
+	 * triggering alerts. Will be replaced by values queried from initial
+	 * HOSTCMD requests.
+	 */
+	ts->psy_stats.capacity = 100;
+	ts->psy_stats.temp = 182;
+
+	shield_dev->battery_dev.desc.properties = thunderstrike_battery_props;
+	shield_dev->battery_dev.desc.num_properties =
+		ARRAY_SIZE(thunderstrike_battery_props);
+	shield_dev->battery_dev.desc.get_property = thunderstrike_battery_get_property;
+	shield_dev->battery_dev.desc.type = POWER_SUPPLY_TYPE_BATTERY;
+	shield_dev->battery_dev.desc.name =
+		devm_kasprintf(&ts->base.hdev->dev, GFP_KERNEL,
+			       "thunderstrike_%d", ts->id);
+
+	shield_dev->battery_dev.psy = power_supply_register(
+		&hdev->dev, &shield_dev->battery_dev.desc, &psy_cfg);
+	if (IS_ERR(shield_dev->battery_dev.psy)) {
+		hid_err(hdev, "Failed to register Thunderstrike battery device\n");
+		return PTR_ERR(shield_dev->battery_dev.psy);
+	}
+
+	ret = power_supply_powers(shield_dev->battery_dev.psy, &hdev->dev);
+	if (ret) {
+		hid_err(hdev, "Failed to associate battery device to Thunderstrike\n");
+		goto err;
+	}
+
+	return 0;
+
+err:
+	power_supply_unregister(shield_dev->battery_dev.psy);
+	return ret;
+}
+
 static struct shield_device *thunderstrike_create(struct hid_device *hdev)
 {
 	struct shield_device *shield_dev;
@@ -509,27 +871,47 @@ static struct shield_device *thunderstrike_create(struct hid_device *hdev)
 	shield_dev->codename = "Thunderstrike";
 
 	spin_lock_init(&ts->haptics_update_lock);
+	spin_lock_init(&ts->psy_stats_lock);
 	INIT_WORK(&ts->hostcmd_req_work, thunderstrike_hostcmd_req_work_handler);
 
 	hid_set_drvdata(hdev, shield_dev);
 
+	ts->id = ida_alloc(&thunderstrike_ida, GFP_KERNEL);
+	if (ts->id < 0)
+		return ERR_PTR(ts->id);
+
 	ts->haptics_dev = shield_haptics_create(shield_dev, thunderstrike_play_effect);
-	if (IS_ERR(ts->haptics_dev))
-		return ERR_CAST(ts->haptics_dev);
+	if (IS_ERR(ts->haptics_dev)) {
+		hid_err(hdev, "Failed to create Thunderstrike haptics instance\n");
+		ret = PTR_ERR(ts->haptics_dev);
+		goto err_id;
+	}
+
+	ret = thunderstrike_psy_create(shield_dev);
+	if (ret) {
+		hid_err(hdev, "Failed to create Thunderstrike power supply instance\n");
+		goto err_haptics;
+	}
 
 	ret = thunderstrike_led_create(ts);
 	if (ret) {
 		hid_err(hdev, "Failed to create Thunderstrike LED instance\n");
-		goto err;
+		goto err_psy;
 	}
 
+	timer_setup(&ts->psy_stats_timer, thunderstrike_psy_stats_timer_handler, 0);
+
 	hid_info(hdev, "Registered Thunderstrike controller\n");
 	return shield_dev;
 
-err:
+err_psy:
+	power_supply_unregister(shield_dev->battery_dev.psy);
+err_haptics:
 	if (ts->haptics_dev)
 		input_unregister_device(ts->haptics_dev);
-	return ERR_CAST(ts->haptics_dev);
+err_id:
+	ida_free(&thunderstrike_ida, ts->id);
+	return ERR_PTR(ret);
 }
 
 static int android_input_mapping(struct hid_device *hdev, struct hid_input *hi,
@@ -684,8 +1066,7 @@ static int shield_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err_stop;
 	}
 
-	thunderstrike_request_firmware_version(ts);
-	thunderstrike_request_board_info(ts);
+	thunderstrike_device_init_info(shield_dev);
 
 	return ret;
 
@@ -705,9 +1086,12 @@ static void shield_remove(struct hid_device *hdev)
 	ts = container_of(dev, struct thunderstrike, base);
 
 	hid_hw_close(hdev);
-	led_classdev_unregister(&ts->led_dev);
+	power_supply_unregister(dev->battery_dev.psy);
 	if (ts->haptics_dev)
 		input_unregister_device(ts->haptics_dev);
+	led_classdev_unregister(&ts->led_dev);
+	ida_free(&thunderstrike_ida, ts->id);
+	del_timer_sync(&ts->psy_stats_timer);
 	cancel_work_sync(&ts->hostcmd_req_work);
 	hid_hw_stop(hdev);
 }
-- 
2.40.1

