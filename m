Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659547A576D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 04:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjISCeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 22:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjISCeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 22:34:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB0B10A;
        Mon, 18 Sep 2023 19:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=g4yHT/YRAYrqNY9hH0+amE5WopD9orBCNU9KXQeS03E=; b=KXXPBJYD2OeLsndzhVEyDOnj4u
        GEMZcaIX1K6hbPQ39hrAurScrQ+MGWwM/tbFdq7X73OFiBf944r7nw3UnTtaQGfNpqXVjHKhQcVex
        Qc0sm12sL2IRECBjeRUK9OkOYj+tRtdgIebtyoN30ArbiV4Q7IcIztRyOu+la43W4vV3cpz1KLf0f
        Do7FWLz9TBJrAgBiZO4fVTwKma6GyKIBszYHYE4lQIhw0Sm5a4mflgmePsZ8hrLliI1afVvTSVcsR
        boul1fjJH2VOgxa8QmQryTEZA8nQzYj6yXwOeR6aE8IA3hL6Y/NjICEpkqZ8SxirUlhFLP9Yqq0Fg
        MdwT1bZg==;
Received: from [2601:1c2:980:9ec0::9fed] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qiQZ7-00GjPy-03;
        Tue, 19 Sep 2023 02:34:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] kernel-doc: add a warning prefix option
Date:   Mon, 18 Sep 2023 19:34:15 -0700
Message-ID: <20230919023415.4744-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an environment variable ("KDOC_LABEL") for use by scripts/kernel-doc.
This variable instructs kernel-doc to label each "warning:" line with
a prefix of the KDOC_LABEL value. E.g., using
  KDOC_LABEL="doc" ./scripts/kernel-doc -none -Wall kernel/panic.c
causes kernel-doc warnings to be emitted as "doc warning:", like this:
  kernel/panic.c:497: doc warning: No description found for return value of 'print_tainted'

This can aid either in finding or eliminating kernel-doc warnings.
'sparse' does something similar to this, although it uses a command line
option (-fdiagnostic-prefix[=prefix]).

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 scripts/kernel-doc |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff -- a/scripts/kernel-doc b/scripts/kernel-doc
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -127,6 +127,7 @@ if ($#ARGV == -1) {
 }
 
 my $kernelversion;
+my $line_label;
 my ($sphinx_major, $sphinx_minor, $sphinx_patch);
 
 my $dohighlight = "";
@@ -439,6 +440,16 @@ sub get_kernel_version() {
     return $version;
 }
 
+# get line label from env
+sub get_line_label() {
+    my $label = '';
+
+    if (defined($ENV{'KDOC_LABEL'})) {
+	$label = $ENV{'KDOC_LABEL'} . " ";
+    }
+    return $label;
+}
+
 #
 sub print_lineno {
     my $lineno = shift;
@@ -450,7 +461,7 @@ sub print_lineno {
 sub emit_warning {
     my $location = shift;
     my $msg = shift;
-    print STDERR "$location: warning: $msg";
+    print STDERR "$location: ${line_label}warning: $msg";
     ++$warnings;
 }
 ##
@@ -2360,6 +2371,8 @@ if ($output_mode eq "rst") {
 
 $kernelversion = get_kernel_version();
 
+$line_label = get_line_label();
+
 # generate a sequence of code that will splice in highlighting information
 # using the s// operator.
 for (my $k = 0; $k < @highlights; $k++) {
