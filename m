Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F0A78C7C4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbjH2Oim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237012AbjH2Oi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:38:27 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1A21AE;
        Tue, 29 Aug 2023 07:38:20 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37TBwku8022670;
        Tue, 29 Aug 2023 15:40:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=cjpw0qMq1w37JRDndUFptdySW5NdRruZOLIYm1872aA=; b=sO
        iabn6zFkWNuNYqYku/H7W0x2xXHoWpzWtEBlSqBI2B+AHZzveUP3ck8Ljj8pdetl
        crMUbtvpz+9u2GSH/+vCzUNFjuiLsnJUxCtuRXG/jnY0gjx9AvxeaofXfEj+i39s
        +awzKc8eky0mgzmxR0KtQqhJVg73Ehb45dKK2s7Ne3JEwdhtBSbx9LJdoSHdFOyl
        Cpp8GT5bJaqvPS6cIpObFjLD8f5DvYfiIamm6ZsTR2yAeze2QcPS4+uxb/eh9bRB
        p7Okon5Ntdspf2rejeTkW1+7uNcvjLyylEX+BbOzJQ6aDyLt8X4H+anfknE/F6sP
        1N0VJ+Y3/WziGBFuxwOg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sq8qwc3jc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 15:40:57 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E10D1100057;
        Tue, 29 Aug 2023 15:40:56 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D59DD2207DB;
        Tue, 29 Aug 2023 15:40:56 +0200 (CEST)
Received: from localhost (10.201.22.39) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 29 Aug
 2023 15:40:56 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <william.gray@linaro.org>, <lee@kernel.org>
CC:     <alexandre.torgue@foss.st.com>, <fabrice.gasnier@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/8] tools/counter: add a flexible watch events tool
Date:   Tue, 29 Aug 2023 15:40:24 +0200
Message-ID: <20230829134029.2402868-4-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230829134029.2402868-1-fabrice.gasnier@foss.st.com>
References: <20230829134029.2402868-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.22.39]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_10,2023-08-29_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new counter tool to be able to test various watch events.
A flexible watch array can be populated from command line, each field
may be tuned with a dedicated command line argument.
Each argument can be repeated several times: each time it gets repeated,
a corresponding new watch element is allocated.

It also comes with a simple default watch (to monitor overflows), used
when no watch parameters are provided.

The print_usage() routine proposes another example, from the command line,
which generates a 2 elements watch array, to monitor:
- overflow events
- capture events, on channel 3, that reads read captured data by
  specifying the component id (capture3_component_id being 7 here).

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 tools/counter/Build                  |   1 +
 tools/counter/Makefile               |   8 +-
 tools/counter/counter_watch_events.c | 348 +++++++++++++++++++++++++++
 3 files changed, 356 insertions(+), 1 deletion(-)
 create mode 100644 tools/counter/counter_watch_events.c

diff --git a/tools/counter/Build b/tools/counter/Build
index 33f4a51d715e..4bbadb7ec93a 100644
--- a/tools/counter/Build
+++ b/tools/counter/Build
@@ -1 +1,2 @@
 counter_example-y += counter_example.o
+counter_watch_events-y += counter_watch_events.o
diff --git a/tools/counter/Makefile b/tools/counter/Makefile
index b2c2946f44c9..00e211edd768 100644
--- a/tools/counter/Makefile
+++ b/tools/counter/Makefile
@@ -14,7 +14,7 @@ MAKEFLAGS += -r
 
 override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
 
-ALL_TARGETS := counter_example
+ALL_TARGETS := counter_example counter_watch_events
 ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
 
 all: $(ALL_PROGRAMS)
@@ -31,6 +31,12 @@ $(OUTPUT)include/linux/counter.h: ../../include/uapi/linux/counter.h
 
 prepare: $(OUTPUT)include/linux/counter.h
 
+COUNTER_WATCH_EVENTS := $(OUTPUT)counter_watch_events.o
+$(COUNTER_WATCH_EVENTS): prepare FORCE
+	$(Q)$(MAKE) $(build)=counter_watch_events
+$(OUTPUT)counter_watch_events: $(COUNTER_WATCH_EVENTS)
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
+
 COUNTER_EXAMPLE := $(OUTPUT)counter_example.o
 $(COUNTER_EXAMPLE): prepare FORCE
 	$(Q)$(MAKE) $(build)=counter_example
diff --git a/tools/counter/counter_watch_events.c b/tools/counter/counter_watch_events.c
new file mode 100644
index 000000000000..7f73a1519d8e
--- /dev/null
+++ b/tools/counter/counter_watch_events.c
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Counter - Test various watch events in a userspace application
+ * inspired by counter_example.c
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <linux/counter.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+static struct counter_watch simple_watch[] = {
+	{
+		/* Component data: Count 0 count */
+		.component.type = COUNTER_COMPONENT_COUNT,
+		.component.scope = COUNTER_SCOPE_COUNT,
+		.component.parent = 0,
+		/* Event type: Index */
+		.event = COUNTER_EVENT_OVERFLOW_UNDERFLOW,
+		/* Device event channel 0 */
+		.channel = 0,
+	},
+};
+
+static int find_match_or_number_from_array(char *arg, const char * const str[], int sz, __u8 *val)
+{
+	unsigned int i;
+	char *dummy;
+	unsigned long idx;
+	int ret;
+
+	for (i = 0; i < sz; i++) {
+		ret = strncmp(arg, str[i], strlen(str[i]));
+		if (!ret && strlen(str[i]) == strlen(arg)) {
+			*val = i;
+			return 0;
+		}
+	}
+
+	/* fallback to number */
+	idx = strtoul(optarg, &dummy, 10);
+	if (!errno) {
+		if (idx >= sz)
+			return -EINVAL;
+		*val = idx;
+		return 0;
+	}
+
+	return -errno;
+}
+
+static const char * const counter_event_type_name[] = {
+	"COUNTER_EVENT_OVERFLOW",
+	"COUNTER_EVENT_UNDERFLOW",
+	"COUNTER_EVENT_OVERFLOW_UNDERFLOW",
+	"COUNTER_EVENT_THRESHOLD",
+	"COUNTER_EVENT_INDEX",
+	"COUNTER_EVENT_CHANGE_OF_STATE",
+	"COUNTER_EVENT_CAPTURE",
+};
+
+static int counter_arg_to_event_type(char *arg, __u8 *event)
+{
+	return find_match_or_number_from_array(arg, counter_event_type_name,
+					       ARRAY_SIZE(counter_event_type_name), event);
+}
+
+static const char * const counter_component_type_name[] = {
+	"COUNTER_COMPONENT_NONE",
+	"COUNTER_COMPONENT_SIGNAL",
+	"COUNTER_COMPONENT_COUNT",
+	"COUNTER_COMPONENT_FUNCTION",
+	"COUNTER_COMPONENT_SYNAPSE_ACTION",
+	"COUNTER_COMPONENT_EXTENSION",
+};
+
+static int counter_arg_to_component_type(char *arg, __u8 *type)
+{
+	return find_match_or_number_from_array(arg, counter_component_type_name,
+					       ARRAY_SIZE(counter_component_type_name), type);
+}
+
+static const char * const counter_scope_name[] = {
+	"COUNTER_SCOPE_DEVICE",
+	"COUNTER_SCOPE_SIGNAL",
+	"COUNTER_SCOPE_COUNT",
+};
+
+static int counter_arg_to_scope(char *arg, __u8 *type)
+{
+	return find_match_or_number_from_array(arg, counter_scope_name,
+					       ARRAY_SIZE(counter_scope_name), type);
+}
+
+static void print_usage(void)
+{
+	fprintf(stderr, "Usage: counter_watch_events [options]...\n"
+		"Test various watch events for given counter device\n"
+		"  --channel -c <n>\n"
+		"        Set watch.channel\n"
+		"  --debug -d\n"
+		"        Prints debug information\n"
+		"  --event -e <number or counter_event_type string>\n"
+		"        Sets watch.event\n"
+		"  --help -h\n"
+		"        Prints usage\n"
+		"  --device-num -n <n>\n"
+		"        Set device number (/dev/counter<n>, default to 0)\n"
+		"  --id -i <n>\n"
+		"        Set watch.component.id\n"
+		"  --loop -l <n>\n"
+		"        Loop for a number of events (forever if n < 0)\n"
+		"  --parent -p <n>\n"
+		"        Set watch.component.parent number\n"
+		"  --scope -s <number or counter_scope string>\n"
+		"        Set watch.component.scope\n"
+		"  --type -t <number or counter_component_type string>\n"
+		"        Set watch.component.type\n"
+		"\n"
+		"Example with two watched events:\n\n"
+		"counter_watch_events -d \\\n"
+		"\t-t COUNTER_COMPONENT_COUNT -s COUNTER_SCOPE_COUNT"
+		" -e COUNTER_EVENT_OVERFLOW_UNDERFLOW -i 0 -c 0 \\\n"
+		"\t-t COUNTER_COMPONENT_EXTENSION -s COUNTER_SCOPE_COUNT"
+		" -e COUNTER_EVENT_CAPTURE -i 7 -c 3\n"
+		);
+}
+
+static void print_watch(struct counter_watch *watch, int nwatch)
+{
+	int i;
+
+	/* prints the watch array in C-like structure */
+	printf("watch[%d] = {\n", nwatch);
+	for (i = 0; i < nwatch; i++) {
+		printf(" [%d] =\t{\n"
+		       "\t\t.component.type = %s\n"
+		       "\t\t.component.scope = %s\n"
+		       "\t\t.component.parent = %d\n"
+		       "\t\t.component.id = %d\n"
+		       "\t\t.event = %s\n"
+		       "\t\t.channel = %d\n"
+		       "\t},\n",
+		       i,
+		       counter_component_type_name[watch[i].component.type],
+		       counter_scope_name[watch[i].component.scope],
+		       watch[i].component.parent,
+		       watch[i].component.id,
+		       counter_event_type_name[watch[i].event],
+		       watch[i].channel);
+	}
+	printf("};\n");
+}
+
+static const struct option longopts[] = {
+	{ "channel",		required_argument, 0, 'c' },
+	{ "debug",		no_argument,       0, 'd' },
+	{ "event",		required_argument, 0, 'e' },
+	{ "help",		no_argument,       0, 'h' },
+	{ "device-num",		required_argument, 0, 'n' },
+	{ "id",			required_argument, 0, 'i' },
+	{ "loop",		required_argument, 0, 'l' },
+	{ "parent",		required_argument, 0, 'p' },
+	{ "scope",		required_argument, 0, 's' },
+	{ "type",		required_argument, 0, 't' },
+	{ },
+};
+
+int main(int argc, char **argv)
+{
+	int c, fd, i, ret;
+	struct counter_event event_data;
+	char *device_name = NULL;
+	int debug = 0, loop = -1;
+	char *dummy;
+	int dev_num = 0, nwatch = 0, ncfg[] = {0, 0, 0, 0, 0, 0};
+	int num_chan = 0, num_evt = 0, num_id = 0, num_p = 0, num_s = 0, num_t = 0;
+	struct counter_watch *watches;
+
+	/*
+	 * 1st pass: count events configurations number to allocate the watch array.
+	 * Each watch argument can be repeated several times: each time it gets repeated,
+	 * a corresponding watch is allocated (and configured) in 2nd pass.
+	 */
+	while ((c = getopt_long(argc, argv, "c:de:hn:i:l:p:s:t:", longopts, NULL)) != -1) {
+		switch (c) {
+		case 'c':
+			ncfg[0]++;
+			break;
+		case 'e':
+			ncfg[1]++;
+			break;
+		case 'i':
+			ncfg[2]++;
+			break;
+		case 'p':
+			ncfg[3]++;
+			break;
+		case 's':
+			ncfg[4]++;
+			break;
+		case 't':
+			ncfg[5]++;
+			break;
+		};
+	};
+
+	for (i = 0; i < ARRAY_SIZE(ncfg); i++)
+		if (ncfg[i] > nwatch)
+			nwatch = ncfg[i];
+
+	if (nwatch) {
+		watches = calloc(nwatch, sizeof(*watches));
+	} else {
+		/* default to simple watch example */
+		watches = simple_watch;
+		nwatch = ARRAY_SIZE(simple_watch);
+	}
+
+	/* 2nd pass: read arguments to fill in watch array */
+	optind = 1;
+	while ((c = getopt_long(argc, argv, "c:de:hn:i:l:p:s:t:", longopts, NULL)) != -1) {
+		switch (c) {
+		case 'c':
+			/* watch.channel */
+			watches[num_chan].channel = strtoul(optarg, &dummy, 10);
+			if (errno)
+				return -errno;
+			num_chan++;
+			break;
+		case 'd':
+			debug = 1;
+			break;
+		case 'e':
+			/* watch.event */
+			ret = counter_arg_to_event_type(optarg, &watches[num_evt].event);
+			if (ret)
+				return ret;
+			num_evt++;
+			break;
+		case 'h':
+			print_usage();
+			return -1;
+		case 'n':
+			errno = 0;
+			dev_num = strtoul(optarg, &dummy, 10);
+			if (errno)
+				return -errno;
+			break;
+		case 'i':
+			/* watch.component.id */
+			watches[num_id].component.id = strtoul(optarg, &dummy, 10);
+			if (errno)
+				return -errno;
+			num_id++;
+			break;
+		case 'l':
+			loop = strtol(optarg, &dummy, 10);
+			if (errno)
+				return -errno;
+			break;
+		case 'p':
+			/* watch.component.parent */
+			watches[num_p].component.parent = strtoul(optarg, &dummy, 10);
+			if (errno)
+				return -errno;
+			num_p++;
+			break;
+		case 's':
+			/* watch.component.scope */
+			ret = counter_arg_to_scope(optarg, &watches[num_s].component.scope);
+			if (ret)
+				return ret;
+			num_s++;
+			break;
+		case 't':
+			/* watch.component.type */
+			ret = counter_arg_to_component_type(optarg, &watches[num_t].component.type);
+			if (ret)
+				return ret;
+			num_t++;
+			break;
+		}
+
+	};
+
+	if (debug)
+		print_watch(watches, nwatch);
+
+	ret = asprintf(&device_name, "/dev/counter%d", dev_num);
+	if (ret < 0)
+		return -ENOMEM;
+
+	if (debug)
+		printf("Opening %s\n", device_name);
+
+	fd = open(device_name, O_RDWR);
+	if (fd == -1) {
+		perror("Unable to open counter device");
+		return 1;
+	}
+
+	for (i = 0; i < nwatch; i++) {
+		ret = ioctl(fd, COUNTER_ADD_WATCH_IOCTL, watches + i);
+		if (ret == -1) {
+			fprintf(stderr, "Error adding watches[%d]: %s\n", i,
+				strerror(errno));
+			return 1;
+		}
+	}
+
+	ret = ioctl(fd, COUNTER_ENABLE_EVENTS_IOCTL);
+	if (ret == -1) {
+		perror("Error enabling events");
+		return 1;
+	}
+
+	for (i = 0; loop <= 0 || i < loop; i++) {
+		ret = read(fd, &event_data, sizeof(event_data));
+		if (ret == -1) {
+			perror("Failed to read event data");
+			return 1;
+		}
+
+		if (ret != sizeof(event_data)) {
+			fprintf(stderr, "Failed to read event data\n");
+			return -EIO;
+		}
+
+		printf("Timestamp: %llu\tData: %llu\t event: %s\tch: %d\n",
+		       event_data.timestamp, event_data.value,
+		       counter_event_type_name[event_data.watch.event],
+		       event_data.watch.channel);
+
+		if (event_data.status) {
+			fprintf(stderr, "Error %d: %s\n", event_data.status,
+				strerror(event_data.status));
+		}
+	}
+
+	return 0;
+}
-- 
2.25.1

