Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD65A80766A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjLFRU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379714AbjLFQsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:48:13 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B781D47;
        Wed,  6 Dec 2023 08:48:17 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6CrCxg017119;
        Wed, 6 Dec 2023 17:48:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=cX/qsGPlWON8R1FYUfR6ohqkcM6tZTRwyVxD5fLjvTc=; b=oI
        6zPVQqwFqnca0K/50Jc4JfG2Bxj+gDpYgrg8OqBu1Usc0TnuPZ/B2QWVxq0Qe915
        3XZFii37iU7DaKRLtsrfPY8/4yYluweD5G+HDq7KiZc5kZUA98V0kzvHpqSj5MYv
        QfwVz0RjlbcZn4f5fRdzxm7dNkvylbMhubBT+9Kg9A4t1wgPMFaOeeC1lsn9Bk6R
        WxDJZukFFOWjWgmqU/461JOD1IBYNEVcX7KOoxOcrsxRU5Z1NHp+UUv/Q4zzcA8I
        w8m2+S4idJsxS9LrON+Ay+rUDIGTGPMihpCtoqXI+iYqICQ0/0KBlW8mPmS5n9il
        ZdjEtevAjd77sj6Veo+A==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3utd2jc0as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Dec 2023 17:48:14 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 50C11100052;
        Wed,  6 Dec 2023 17:48:14 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 48FEE26C9F0;
        Wed,  6 Dec 2023 17:48:14 +0100 (CET)
Received: from localhost (10.201.20.59) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Dec
 2023 17:48:13 +0100
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <william.gray@linaro.org>
CC:     <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] tools/counter: add a flexible watch events tool
Date:   Wed, 6 Dec 2023 17:47:25 +0100
Message-ID: <20231206164726.418990-2-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206164726.418990-1-fabrice.gasnier@foss.st.com>
References: <20231206164726.418990-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.59]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_15,2023-12-06_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new counter tool to be able to test various watch events.
A flexible watch array can be populated from command line, each field
may be tuned with a dedicated command line sub-option in "--watch" string.
Several watch events can be defined, each can have specific watch options,
by using "--watch <watch 1 options> --watch <watch 2 options>".
Watch options is a comma separated list.

It also comes with a simple default watch (to monitor overflow/underflow
events), used when no watch parameters are provided. It's equivalent to:
counter_watch_events -w comp_count,scope_count,evt_ovf_udf

The print_usage() routine proposes another example, from the command line,
which generates a 2 elements watch array, to monitor:
- overflow underflow events
- capture events, on channel 3, that reads read captured data by
  specifying the component id (capture3_component_id being 7 here).

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v3:
- Free the allocated memory, also close the char device
- Split of another patch series[1].
[1] https://lore.kernel.org/lkml/20230922143920.3144249-1-fabrice.gasnier@foss.st.com/

Changes in v2:
Review comments from William:
- revisit watch options to be less error prone: add --watch with
  sub-options to properly define each watch one by one, as a comma
  separated list
- by the way, drop string/array parsing routines, replaced by getsubopt()
- Improve command-line interface descriptions, e.g. like "-h, --help"
- Makefile: adopt ARRAY_SIZE from tools/include/linux.kernel.h (via CFLAG)
- remove reference to counter_example
- clarify commit message, code comment: Index/overflow/underflow event
- check calloc return value
- Makefile: sort count_watch_events in alphabetic order
- Makefile: add a clean rule to delete .*.o.cmd files
---
 tools/counter/Build                  |   1 +
 tools/counter/Makefile               |  12 +-
 tools/counter/counter_watch_events.c | 372 +++++++++++++++++++++++++++
 3 files changed, 383 insertions(+), 2 deletions(-)
 create mode 100644 tools/counter/counter_watch_events.c

diff --git a/tools/counter/Build b/tools/counter/Build
index 33f4a51d715e..4bbadb7ec93a 100644
--- a/tools/counter/Build
+++ b/tools/counter/Build
@@ -1 +1,2 @@
 counter_example-y += counter_example.o
+counter_watch_events-y += counter_watch_events.o
diff --git a/tools/counter/Makefile b/tools/counter/Makefile
index b2c2946f44c9..d82d35a520f6 100644
--- a/tools/counter/Makefile
+++ b/tools/counter/Makefile
@@ -12,9 +12,10 @@ endif
 # (this improves performance and avoids hard-to-debug behaviour);
 MAKEFLAGS += -r
 
-override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
+override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include \
+	 -I$(srctree)/tools/include
 
-ALL_TARGETS := counter_example
+ALL_TARGETS := counter_example counter_watch_events
 ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
 
 all: $(ALL_PROGRAMS)
@@ -37,12 +38,19 @@ $(COUNTER_EXAMPLE): prepare FORCE
 $(OUTPUT)counter_example: $(COUNTER_EXAMPLE)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
 
+COUNTER_WATCH_EVENTS := $(OUTPUT)counter_watch_events.o
+$(COUNTER_WATCH_EVENTS): prepare FORCE
+	$(Q)$(MAKE) $(build)=counter_watch_events
+$(OUTPUT)counter_watch_events: $(COUNTER_WATCH_EVENTS)
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
+
 clean:
 	rm -f $(ALL_PROGRAMS)
 	rm -rf $(OUTPUT)include/linux/counter.h
 	rm -df $(OUTPUT)include/linux
 	rm -df $(OUTPUT)include
 	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
+	find $(or $(OUTPUT),.) -name '\.*.o.cmd' -delete
 
 install: $(ALL_PROGRAMS)
 	install -d -m 755 $(DESTDIR)$(bindir);		\
diff --git a/tools/counter/counter_watch_events.c b/tools/counter/counter_watch_events.c
new file mode 100644
index 000000000000..06730bd546d8
--- /dev/null
+++ b/tools/counter/counter_watch_events.c
@@ -0,0 +1,372 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Counter Watch Events - Test various counter watch events in a userspace application */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <linux/counter.h>
+#include <linux/kernel.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+
+static struct counter_watch simple_watch[] = {
+	{
+		/* Component data: Count 0 count */
+		.component.type = COUNTER_COMPONENT_COUNT,
+		.component.scope = COUNTER_SCOPE_COUNT,
+		.component.parent = 0,
+		/* Event type: overflow or underflow */
+		.event = COUNTER_EVENT_OVERFLOW_UNDERFLOW,
+		/* Device event channel 0 */
+		.channel = 0,
+	},
+};
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
+static const char * const counter_component_type_name[] = {
+	"COUNTER_COMPONENT_NONE",
+	"COUNTER_COMPONENT_SIGNAL",
+	"COUNTER_COMPONENT_COUNT",
+	"COUNTER_COMPONENT_FUNCTION",
+	"COUNTER_COMPONENT_SYNAPSE_ACTION",
+	"COUNTER_COMPONENT_EXTENSION",
+};
+
+static const char * const counter_scope_name[] = {
+	"COUNTER_SCOPE_DEVICE",
+	"COUNTER_SCOPE_SIGNAL",
+	"COUNTER_SCOPE_COUNT",
+};
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
+static void print_usage(void)
+{
+	fprintf(stderr, "Usage:\n\n"
+		"counter_watch_events [options] [-w <watchoptions>]\n"
+		"counter_watch_events [options] [-w <watch1 options>] [-w <watch2 options>]...\n"
+		"\n"
+		"When no --watch option has been provided, simple watch example is used:\n"
+		"counter_watch_events [options] -w comp_count,scope_count,evt_ovf_udf\n"
+		"\n"
+		"Test various watch events for given counter device.\n"
+		"\n"
+		"Options:\n"
+		"  -d, --debug                Prints debug information\n"
+		"  -h, --help                 Prints usage\n"
+		"  -n, --device-num <n>       Use /dev/counter<n> [default: /dev/counter0]\n"
+		"  -l, --loop <n>             Loop for <n> events [default: 0 (forever)]\n"
+		"  -w, --watch <watchoptions> comma-separated list of watch options\n"
+		"\n"
+		"Watch options:\n"
+		"  scope_device               (COUNTER_SCOPE_DEVICE) [default: scope_device]\n"
+		"  scope_signal               (COUNTER_SCOPE_SIGNAL)\n"
+		"  scope_count                (COUNTER_SCOPE_COUNT)\n"
+		"\n"
+		"  comp_none                  (COUNTER_COMPONENT_NONE) [default: comp_none]\n"
+		"  comp_signal                (COUNTER_COMPONENT_SIGNAL)\n"
+		"  comp_count                 (COUNTER_COMPONENT_COUNT)\n"
+		"  comp_function              (COUNTER_COMPONENT_FUNCTION)\n"
+		"  comp_synapse_action        (COUNTER_COMPONENT_SYNAPSE_ACTION)\n"
+		"  comp_extension             (COUNTER_COMPONENT_EXTENSION)\n"
+		"\n"
+		"  evt_ovf                    (COUNTER_EVENT_OVERFLOW) [default: evt_ovf]\n"
+		"  evt_udf                    (COUNTER_EVENT_UNDERFLOW)\n"
+		"  evt_ovf_udf                (COUNTER_EVENT_OVERFLOW_UNDERFLOW)\n"
+		"  evt_threshold              (COUNTER_EVENT_THRESHOLD)\n"
+		"  evt_index                  (COUNTER_EVENT_INDEX)\n"
+		"  evt_change_of_state        (COUNTER_EVENT_CHANGE_OF_STATE)\n"
+		"  evt_capture                (COUNTER_EVENT_CAPTURE)\n"
+		"\n"
+		"  chan=<n>                   channel <n> for this watch [default: 0]\n"
+		"  id=<n>                     componend id <n> for this watch [default: 0]\n"
+		"  parent=<n>                 componend parent <n> for this watch [default: 0]\n"
+		"\n"
+		"Example with two watched events:\n\n"
+		"counter_watch_events -d \\\n"
+		"\t-w comp_count,scope_count,evt_ovf_udf \\\n"
+		"\t-w comp_extension,scope_count,evt_capture,id=7,chan=3\n"
+		);
+}
+
+static const struct option longopts[] = {
+	{ "debug",		no_argument,       0, 'd' },
+	{ "help",		no_argument,       0, 'h' },
+	{ "device-num",		required_argument, 0, 'n' },
+	{ "loop",		required_argument, 0, 'l' },
+	{ "watch",		required_argument, 0, 'w' },
+	{ },
+};
+
+/* counter watch subopts */
+enum {
+	WATCH_SCOPE_DEVICE,
+	WATCH_SCOPE_SIGNAL,
+	WATCH_SCOPE_COUNT,
+	WATCH_COMPONENT_NONE,
+	WATCH_COMPONENT_SIGNAL,
+	WATCH_COMPONENT_COUNT,
+	WATCH_COMPONENT_FUNCTION,
+	WATCH_COMPONENT_SYNAPSE_ACTION,
+	WATCH_COMPONENT_EXTENSION,
+	WATCH_EVENT_OVERFLOW,
+	WATCH_EVENT_UNDERFLOW,
+	WATCH_EVENT_OVERFLOW_UNDERFLOW,
+	WATCH_EVENT_THRESHOLD,
+	WATCH_EVENT_INDEX,
+	WATCH_EVENT_CHANGE_OF_STATE,
+	WATCH_EVENT_CAPTURE,
+	WATCH_CHANNEL,
+	WATCH_ID,
+	WATCH_PARENT,
+	WATCH_SUBOPTS_MAX,
+};
+
+static char * const counter_watch_subopts[WATCH_SUBOPTS_MAX + 1] = {
+	/* component.scope */
+	[WATCH_SCOPE_DEVICE] = "scope_device",
+	[WATCH_SCOPE_SIGNAL] = "scope_signal",
+	[WATCH_SCOPE_COUNT] = "scope_count",
+	/* component.type */
+	[WATCH_COMPONENT_NONE] = "comp_none",
+	[WATCH_COMPONENT_SIGNAL] = "comp_signal",
+	[WATCH_COMPONENT_COUNT] = "comp_count",
+	[WATCH_COMPONENT_FUNCTION] = "comp_function",
+	[WATCH_COMPONENT_SYNAPSE_ACTION] = "comp_synapse_action",
+	[WATCH_COMPONENT_EXTENSION] = "comp_extension",
+	/* event */
+	[WATCH_EVENT_OVERFLOW] = "evt_ovf",
+	[WATCH_EVENT_UNDERFLOW] = "evt_udf",
+	[WATCH_EVENT_OVERFLOW_UNDERFLOW] = "evt_ovf_udf",
+	[WATCH_EVENT_THRESHOLD] = "evt_threshold",
+	[WATCH_EVENT_INDEX] = "evt_index",
+	[WATCH_EVENT_CHANGE_OF_STATE] = "evt_change_of_state",
+	[WATCH_EVENT_CAPTURE] = "evt_capture",
+	/* channel, id, parent */
+	[WATCH_CHANNEL] = "chan",
+	[WATCH_ID] = "id",
+	[WATCH_PARENT] = "parent",
+	/* Empty entry ends the opts array */
+	NULL
+};
+
+int main(int argc, char **argv)
+{
+	int c, fd, i, ret, debug = 0, loop = 0, dev_num = 0, nwatch = 0;
+	struct counter_event event_data;
+	char *device_name = NULL, *subopts, *value;
+	struct counter_watch *watches;
+
+	/*
+	 * 1st pass:
+	 * - list watch events number to allocate the watch array.
+	 * - parse normal options (other than watch options)
+	 */
+	while ((c = getopt_long(argc, argv, "dhn:l:w:", longopts, NULL)) != -1) {
+		switch (c) {
+		case 'd':
+			debug = 1;
+			break;
+		case 'h':
+			print_usage();
+			return -1;
+		case 'n':
+			dev_num = strtoul(optarg, NULL, 10);
+			if (errno)
+				return -errno;
+			break;
+		case 'l':
+			loop = strtol(optarg, NULL, 10);
+			if (errno)
+				return -errno;
+			break;
+		case 'w':
+			nwatch++;
+			break;
+		default:
+			return -1;
+		};
+	};
+
+	if (nwatch) {
+		watches = calloc(nwatch, sizeof(*watches));
+		if (!watches) {
+			perror("Error allocating watches");
+			return 1;
+		}
+	} else {
+		/* default to simple watch example */
+		watches = simple_watch;
+		nwatch = ARRAY_SIZE(simple_watch);
+	}
+
+	/* 2nd pass: parse watch sub-options to fill in watch array */
+	optind = 1;
+	i = 0;
+	while ((c = getopt_long(argc, argv, "dhn:l:w:", longopts, NULL)) != -1) {
+		switch (c) {
+		case 'w':
+			subopts = optarg;
+			while (*subopts != '\0') {
+				ret = getsubopt(&subopts, counter_watch_subopts, &value);
+				switch (ret) {
+				case WATCH_SCOPE_DEVICE:
+				case WATCH_SCOPE_SIGNAL:
+				case WATCH_SCOPE_COUNT:
+					/* match with counter_scope */
+					watches[i].component.scope = ret;
+					break;
+				case WATCH_COMPONENT_NONE:
+				case WATCH_COMPONENT_SIGNAL:
+				case WATCH_COMPONENT_COUNT:
+				case WATCH_COMPONENT_FUNCTION:
+				case WATCH_COMPONENT_SYNAPSE_ACTION:
+				case WATCH_COMPONENT_EXTENSION:
+					/* match counter_component_type: subtract enum value */
+					ret -= WATCH_COMPONENT_NONE;
+					watches[i].component.type = ret;
+					break;
+				case WATCH_EVENT_OVERFLOW:
+				case WATCH_EVENT_UNDERFLOW:
+				case WATCH_EVENT_OVERFLOW_UNDERFLOW:
+				case WATCH_EVENT_THRESHOLD:
+				case WATCH_EVENT_INDEX:
+				case WATCH_EVENT_CHANGE_OF_STATE:
+				case WATCH_EVENT_CAPTURE:
+					/* match counter_event_type: subtract enum value */
+					ret -= WATCH_EVENT_OVERFLOW;
+					watches[i].event = ret;
+					break;
+				case WATCH_CHANNEL:
+					if (!value) {
+						fprintf(stderr, "Missing chan=<number>\n");
+						return -EINVAL;
+					}
+					watches[i].channel = strtoul(value, NULL, 10);
+					if (errno)
+						return -errno;
+					break;
+				case WATCH_ID:
+					if (!value) {
+						fprintf(stderr, "Missing id=<number>\n");
+						return -EINVAL;
+					}
+					watches[i].component.id = strtoul(value, NULL, 10);
+					if (errno)
+						return -errno;
+					break;
+				case WATCH_PARENT:
+					if (!value) {
+						fprintf(stderr, "Missing parent=<number>\n");
+						return -EINVAL;
+					}
+					watches[i].component.parent = strtoul(value, NULL, 10);
+					if (errno)
+						return -errno;
+					break;
+				default:
+					fprintf(stderr, "Unknown suboption '%s'\n", value);
+					return -EINVAL;
+				}
+			}
+			i++;
+			break;
+		}
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
+	if (watches != simple_watch)
+		free(watches);
+	close(fd);
+
+	return 0;
+}
-- 
2.25.1

