Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424CE7D83F9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345185AbjJZNzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbjJZNzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:55:45 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DBBD5F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:55:36 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:32d3:3cb9:edce:43ae])
        by michel.telenet-ops.be with bizsmtp
        id 2dva2B0012XL1Wb06dvaV1; Thu, 26 Oct 2023 15:55:34 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qw0pa-007YxL-2V;
        Thu, 26 Oct 2023 15:55:34 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qw0pi-00HAry-1J;
        Thu, 26 Oct 2023 15:55:34 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] scripts: dt_to_config: Fix odd formatting
Date:   Thu, 26 Oct 2023 15:55:32 +0200
Message-Id: <a5fe23a5cf42ff3aa5f1911e9db307b6083374e4.1698328110.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1698328110.git.geert+renesas@glider.be>
References: <cover.1698328110.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dt_to_config scripts use 7 spaces for the first indentation step,
and 8 spaces for any subsequent step, which is rather uncommon.
Replace spaces by TABs and reformat/realign white-space.

No functional change.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 scripts/dtc/dt_to_config | 1766 +++++++++++++++++++-------------------
 1 file changed, 879 insertions(+), 887 deletions(-)

diff --git a/scripts/dtc/dt_to_config b/scripts/dtc/dt_to_config
index 563362f363e8cec1..024f6fc71602402c 100755
--- a/scripts/dtc/dt_to_config
+++ b/scripts/dtc/dt_to_config
@@ -19,19 +19,19 @@ $script_name =~ s|^.*/||;
 # ----- constants for print_flags()
 
 # Position in string $pr_flags.  Range of 0..($num_pr_flags - 1).
-$pr_flag_pos_mcompatible       = 0;
-$pr_flag_pos_driver            = 1;
-$pr_flag_pos_mdriver           = 2;
-$pr_flag_pos_config            = 3;
-$pr_flag_pos_mconfig           = 4;
-$pr_flag_pos_node_not_enabled  = 5;
-$pr_flag_pos_white_list        = 6;
-$pr_flag_pos_hard_coded        = 7;
-$pr_flag_pos_config_hard_coded = 8;
-$pr_flag_pos_config_none       = 9;
-$pr_flag_pos_config_m          = 10;
-$pr_flag_pos_config_y          = 11;
-$pr_flag_pos_config_test_fail  = 12;
+$pr_flag_pos_mcompatible	= 0;
+$pr_flag_pos_driver		= 1;
+$pr_flag_pos_mdriver		= 2;
+$pr_flag_pos_config		= 3;
+$pr_flag_pos_mconfig		= 4;
+$pr_flag_pos_node_not_enabled 	= 5;
+$pr_flag_pos_white_list		= 6;
+$pr_flag_pos_hard_coded		= 7;
+$pr_flag_pos_config_hard_coded	= 8;
+$pr_flag_pos_config_none	= 9;
+$pr_flag_pos_config_m		= 10;
+$pr_flag_pos_config_y		= 11;
+$pr_flag_pos_config_test_fail	= 12;
 
 $num_pr_flags = $pr_flag_pos_config_test_fail + 1;
 
@@ -42,39 +42,39 @@ $num_pr_flags = $pr_flag_pos_config_test_fail + 1;
 @pr_flag_value = ('M', 'd', 'D', 'c', 'C', 'E', 'W', 'H', 'x', 'n', 'm', 'y', 'F');
 
 @pr_flag_help = (
-    "multiple compatibles found for this node",
-    "driver found for this compatible",
-    "multiple drivers found for this compatible",
-    "kernel config found for this driver",
-    "multiple config options found for this driver",
-    "node is not enabled",
-    "compatible is white listed",
-    "matching driver and/or kernel config is hard coded",
-    "kernel config hard coded in Makefile",
-    "one or more kernel config file options is not set",
-    "one or more kernel config file options is set to 'm'",
-    "one or more kernel config file options is set to 'y'",
-    "one of more kernel config file options fails to have correct value"
+	"multiple compatibles found for this node",
+	"driver found for this compatible",
+	"multiple drivers found for this compatible",
+	"kernel config found for this driver",
+	"multiple config options found for this driver",
+	"node is not enabled",
+	"compatible is white listed",
+	"matching driver and/or kernel config is hard coded",
+	"kernel config hard coded in Makefile",
+	"one or more kernel config file options is not set",
+	"one or more kernel config file options is set to 'm'",
+	"one or more kernel config file options is set to 'y'",
+	"one of more kernel config file options fails to have correct value"
 );
 
 
 # -----
 
-%driver_config = ();   # driver config array, indexed by driver source file
-%driver_count = ();    # driver_cnt, indexed by compatible
-%compat_driver = ();   # compatible driver array, indexed by compatible
-%existing_config = (); # existing config symbols present in given config file
-                       # expected values are: "y", "m", a decimal number, a
-                       # hex number, or a string
+%driver_config = ();	# driver config array, indexed by driver source file
+%driver_count = ();	# driver_cnt, indexed by compatible
+%compat_driver = ();	# compatible driver array, indexed by compatible
+%existing_config = ();	# existing config symbols present in given config file
+			# expected values are: "y", "m", a decimal number, a
+			# hex number, or a string
 
 # ----- magic compatibles, do not have a driver
 #
 # Will not search for drivers for these compatibles.
 
 %compat_white_list = (
-       'none'                  => '1',
-       'pci'                   => '1',
-       'simple-bus'            => '1',
+	'none'			=> '1',
+	'pci'			=> '1',
+	'simple-bus'		=> '1',
 );
 
 # Will not search for drivers for these compatibles.
@@ -88,59 +88,59 @@ $num_pr_flags = $pr_flag_pos_config_test_fail + 1;
 # is used.  Are there drivers that can be provided?
 
 %driver_hard_code_list = (
-       'cache'                 => ['hardcoded_no_driver'],
-       'eeprom'                => ['hardcoded_no_driver'],
-       'gpio'                  => ['hardcoded_no_driver'],
-       'gpio-keys'             => ['drivers/input/keyboard/gpio_keys.c'],
-       'i2c-gpio'              => ['drivers/i2c/busses/i2c-gpio.c'],
-       'isa'                   => ['arch/mips/mti-malta/malta-dt.c',
-                                    'arch/x86/kernel/devicetree.c'],
-       'led'                   => ['hardcoded_no_driver'],
-       'm25p32'                => ['hardcoded_no_driver'],
-       'm25p64'                => ['hardcoded_no_driver'],
-       'm25p80'                => ['hardcoded_no_driver'],
-       'mtd-ram'               => ['drivers/mtd/maps/physmap_of.c'],
-       'pwm-backlight'         => ['drivers/video/backlight/pwm_bl.c'],
-       'spidev'                => ['hardcoded_no_driver'],
-       'syscon'                => ['drivers/mfd/syscon.c'],
-       'tlv320aic23'           => ['hardcoded_no_driver'],
-       'wm8731'                => ['hardcoded_no_driver'],
+	'cache'			=> ['hardcoded_no_driver'],
+	'eeprom'		=> ['hardcoded_no_driver'],
+	'gpio'			=> ['hardcoded_no_driver'],
+	'gpio-keys'		=> ['drivers/input/keyboard/gpio_keys.c'],
+	'i2c-gpio'		=> ['drivers/i2c/busses/i2c-gpio.c'],
+	'isa'			=> ['arch/mips/mti-malta/malta-dt.c',
+				    'arch/x86/kernel/devicetree.c'],
+	'led'			=> ['hardcoded_no_driver'],
+	'm25p32'		=> ['hardcoded_no_driver'],
+	'm25p64'		=> ['hardcoded_no_driver'],
+	'm25p80'		=> ['hardcoded_no_driver'],
+	'mtd-ram'		=> ['drivers/mtd/maps/physmap_of.c'],
+	'pwm-backlight'		=> ['drivers/video/backlight/pwm_bl.c'],
+	'spidev'		=> ['hardcoded_no_driver'],
+	'syscon'		=> ['drivers/mfd/syscon.c'],
+	'tlv320aic23'		=> ['hardcoded_no_driver'],
+	'wm8731'		=> ['hardcoded_no_driver'],
 );
 
 # Use these config options instead of searching makefiles
 
 %driver_config_hard_code_list = (
 
-       # this one needed even if %driver_hard_code_list is empty
-       'no_driver'                             => ['no_config'],
-       'hardcoded_no_driver'                   => ['no_config'],
-
-       # drivers/usb/host/ehci-ppc-of.c
-       # drivers/usb/host/ehci-xilinx-of.c
-       #  are included from:
-       #    drivers/usb/host/ehci-hcd.c
-       #  thus the search of Makefile for the included .c files is incorrect
-       # ehci-hcd.c wraps the includes with ifdef CONFIG_USB_EHCI_HCD_..._OF
-       #
-       # similar model for ohci-hcd.c (but no ohci-xilinx-of.c)
-       #
-       # similarly, uhci-hcd.c includes uhci-platform.c
-
-       'drivers/usb/host/ehci-ppc-of.c'        => ['CONFIG_USB_EHCI_HCD',
-                                                   'CONFIG_USB_EHCI_HCD_PPC_OF'],
-       'drivers/usb/host/ohci-ppc-of.c'        => ['CONFIG_USB_OHCI_HCD',
-                                                   'CONFIG_USB_OHCI_HCD_PPC_OF'],
-
-       'drivers/usb/host/ehci-xilinx-of.c'     => ['CONFIG_USB_EHCI_HCD',
-                                                   'CONFIG_USB_EHCI_HCD_XILINX'],
-
-       'drivers/usb/host/uhci-platform.c'      => ['CONFIG_USB_UHCI_HCD',
-                                                   'CONFIG_USB_UHCI_PLATFORM'],
-
-       # scan_makefile will find only one of these config options:
-       #    ifneq ($(CONFIG_SOC_IMX6)$(CONFIG_SOC_LS1021A),)
-       'arch/arm/mach-imx/platsmp.c'           => ['CONFIG_SOC_IMX6 && CONFIG_SMP',
-                                                   'CONFIG_SOC_LS1021A && CONFIG_SMP'],
+	# this one needed even if %driver_hard_code_list is empty
+	'no_driver'				=> ['no_config'],
+	'hardcoded_no_driver'			=> ['no_config'],
+
+	# drivers/usb/host/ehci-ppc-of.c
+	# drivers/usb/host/ehci-xilinx-of.c
+	#  are included from:
+	#    drivers/usb/host/ehci-hcd.c
+	#  thus the search of Makefile for the included .c files is incorrect
+	# ehci-hcd.c wraps the includes with ifdef CONFIG_USB_EHCI_HCD_..._OF
+	#
+	# similar model for ohci-hcd.c (but no ohci-xilinx-of.c)
+	#
+	# similarly, uhci-hcd.c includes uhci-platform.c
+
+	'drivers/usb/host/ehci-ppc-of.c'	=> ['CONFIG_USB_EHCI_HCD',
+						    'CONFIG_USB_EHCI_HCD_PPC_OF'],
+	'drivers/usb/host/ohci-ppc-of.c'	=> ['CONFIG_USB_OHCI_HCD',
+						    'CONFIG_USB_OHCI_HCD_PPC_OF'],
+
+	'drivers/usb/host/ehci-xilinx-of.c'	=> ['CONFIG_USB_EHCI_HCD',
+						    'CONFIG_USB_EHCI_HCD_XILINX'],
+
+	'drivers/usb/host/uhci-platform.c'	=> ['CONFIG_USB_UHCI_HCD',
+						    'CONFIG_USB_UHCI_PLATFORM'],
+
+	# scan_makefile will find only one of these config options:
+	#    ifneq ($(CONFIG_SOC_IMX6)$(CONFIG_SOC_LS1021A),)
+	'arch/arm/mach-imx/platsmp.c'		=> ['CONFIG_SOC_IMX6 && CONFIG_SMP',
+						    'CONFIG_SOC_LS1021A && CONFIG_SMP'],
 );
 
 
@@ -152,14 +152,14 @@ $num_pr_flags = $pr_flag_pos_config_test_fail + 1;
 # black_list_driver.
 
 @black_list_driver = (
-       # kvm no longer a problem after commit 503a62862e8f in 4.7-rc1
-       # 'virt/kvm/arm/.*',
+	# kvm no longer a problem after commit 503a62862e8f in 4.7-rc1
+	# 'virt/kvm/arm/.*',
 );
 
 
 sub usage()
 {
-       print
+	print
 "
 Usage: $script_name [options] device-tree...
 
@@ -231,11 +231,11 @@ Valid options:
   FLAG values:
 ";
 
-       for ($k = 0; $k < $num_pr_flags; $k++) {
-               printf "     %s   %s\n", $pr_flag_value[$k], $pr_flag_help[$k];
-       }
+	for ($k = 0; $k < $num_pr_flags; $k++) {
+		printf "     %s   %s\n", $pr_flag_value[$k], $pr_flag_help[$k];
+	}
 
-       print
+	print
 "
      Upper case letters indicate potential issues or problems.
 
@@ -243,10 +243,10 @@ Valid options:
 
 ";
 
-       $k = $pr_flag_pos_hard_coded;
-       printf "     %s   %s\n", $pr_flag_value[$k], $pr_flag_help[$k];
+	$k = $pr_flag_pos_hard_coded;
+	printf "     %s   %s\n", $pr_flag_value[$k], $pr_flag_help[$k];
 
-       print
+	print
 "
   will be set if the config or driver is in the white lists, even if
   --white-list-config and --white-list-driver are not specified.
@@ -266,718 +266,715 @@ Valid options:
 
   EXAMPLES:
 
-     dt_to_config arch/arm/boot/dts/my_dts_file.dts
+    dt_to_config arch/arm/boot/dts/my_dts_file.dts
 
-       Basic report.
+      Basic report.
 
-     dt_to_config \\
+    dt_to_config \\
         --config \${KBUILD_OUTPUT}/.config \\
         arch/\${ARCH}/boot/dts/my_dts_file.dts
 
-       Full report, with config file issues noted.
+      Full report, with config file issues noted.
 
-     dt_to_config --include-suspect \\
+    dt_to_config --include-suspect \\
         --config \${KBUILD_OUTPUT}/.config \\
         arch/\${ARCH}/boot/dts/my_dts_file.dts
 
-       Report of node / compatible string / driver tuples that should
-       be further investigated.  A node may have multiple compatible
-       strings.  A compatible string may be matched by multiple drivers.
-       A driver may have config file issues noted.  The compatible string
-       and/or driver may be in the white lists.
+      Report of node / compatible string / driver tuples that should
+      be further investigated.  A node may have multiple compatible
+      strings.  A compatible string may be matched by multiple drivers.
+      A driver may have config file issues noted.  The compatible string
+      and/or driver may be in the white lists.
 
-     dt_to_config --include-suspect --config-format \\
+    dt_to_config --include-suspect --config-format \\
         --config ${KBUILD_OUTPUT}/.config \\
         arch/\${ARCH}/boot/dts/my_dts_file.dts
 
-       Report of node / compatible string / driver tuples that should
-       be further investigated.  The report can be edited to uncomment
-       the config options to select the desired tuple for a given node.
-       A node may have multiple compatible strings.  A compatible string
-       may be matched by multiple drivers.  A driver may have config file
-       issues noted.  The compatible string and/or driver may be in the
-       white lists.
+      Report of node / compatible string / driver tuples that should
+      be further investigated.  The report can be edited to uncomment
+      the config options to select the desired tuple for a given node.
+      A node may have multiple compatible strings.  A compatible string
+      may be matched by multiple drivers.  A driver may have config file
+      issues noted.  The compatible string and/or driver may be in the
+      white lists.
 
 ";
 }
 
 sub set_flag()
 {
-       # pr_flags_ref is a reference to $pr_flags
+	# pr_flags_ref is a reference to $pr_flags
 
-       my $pr_flags_ref = shift;
-       my $pos          = shift;
+	my $pr_flags_ref	= shift;
+	my $pos			= shift;
 
-       substr $$pr_flags_ref, $pos, 1, $pr_flag_value[$pos];
+	substr $$pr_flags_ref, $pos, 1, $pr_flag_value[$pos];
 
-       return $pr_flags;
+	return $pr_flags;
 }
 
 sub print_flags()
 {
-       # return 1 if anything printed, else 0
-
-       # some fields of pn_arg_ref might not be used in this function, but
-       # extract all of them anyway.
-       my $pn_arg_ref     = shift;
-
-       my $compat         = $pn_arg_ref->{compat};
-       my $compatible_cnt = $pn_arg_ref->{compatible_cnt};
-       my $config         = $pn_arg_ref->{config};
-       my $config_cnt     = $pn_arg_ref->{config_cnt};
-       my $driver         = $pn_arg_ref->{driver};
-       my $driver_cnt     = $pn_arg_ref->{driver_cnt};
-       my $full_node      = $pn_arg_ref->{full_node};
-       my $node           = $pn_arg_ref->{node};
-       my $node_enabled   = $pn_arg_ref->{node_enabled};
-       my $white_list     = $pn_arg_ref->{white_list};
-
-       my $pr_flags       = '-' x $num_pr_flags;
-
-
-       # ----- set flags in $pr_flags
-
-       if ($compatible_cnt > 1) {
-               &set_flag(\$pr_flags, $pr_flag_pos_mcompatible);
-       }
-
-       if ($config_cnt > 1) {
-               &set_flag(\$pr_flags, $pr_flag_pos_mconfig);
-       }
-
-       if ($driver_cnt >= 1) {
-               &set_flag(\$pr_flags, $pr_flag_pos_driver);
-       }
-
-       if ($driver_cnt > 1) {
-               &set_flag(\$pr_flags, $pr_flag_pos_mdriver);
-       }
-
-       # These strings are the same way the linux kernel tests.
-       # The ePapr lists of values is slightly different.
-       if (!(
-             ($node_enabled eq "") ||
-             ($node_enabled eq "ok") ||
-             ($node_enabled eq "okay")
-            )) {
-               &set_flag(\$pr_flags, $pr_flag_pos_node_not_enabled);
-       }
-
-       if ($white_list) {
-               &set_flag(\$pr_flags, $pr_flag_pos_white_list);
-       }
-
-       if (exists($driver_hard_code_list{$compat}) ||
-           (exists($driver_config_hard_code_list{$driver}) &&
-            ($driver ne "no_driver"))) {
-               &set_flag(\$pr_flags, $pr_flag_pos_hard_coded);
-       }
-
-       my @configs = split(' && ', $config);
-       for $configs (@configs) {
-               $not = $configs =~ /^!/;
-               $configs =~ s/^!//;
-
-               if (($configs ne "no_config") && ($configs ne "no_makefile")) {
-                       &set_flag(\$pr_flags, $pr_flag_pos_config);
-               }
-
-               if (($config_cnt >= 1) &&
-                   ($configs !~ /CONFIG_/) &&
-                   (($configs ne "no_config") && ($configs ne "no_makefile"))) {
-                       &set_flag(\$pr_flags, $pr_flag_pos_config_hard_coded);
-               }
-
-               my $existing_config = $existing_config{$configs};
-               if ($existing_config eq "m") {
-                       &set_flag(\$pr_flags, $pr_flag_pos_config_m);
-                       # Possible fail, depends on whether built in or
-                       # module is desired.
-                       &set_flag(\$pr_flags, $pr_flag_pos_config_test_fail);
-               } elsif ($existing_config eq "y") {
-                       &set_flag(\$pr_flags, $pr_flag_pos_config_y);
-                       if ($not) {
-                               &set_flag(\$pr_flags, $pr_flag_pos_config_test_fail);
-                       }
-               } elsif (($config_file) && ($configs =~ /CONFIG_/)) {
-                       &set_flag(\$pr_flags, $pr_flag_pos_config_none);
-                       if (!$not) {
-                               &set_flag(\$pr_flags, $pr_flag_pos_config_test_fail);
-                       }
-               }
-       }
-
-       # ----- include / exclude filters
-
-       if ($include_flag_pattern && ($pr_flags !~ m/$include_flag_pattern/)) {
-               return 0;
-       }
-
-       if ($exclude_flag_pattern && ($pr_flags =~ m/$exclude_flag_pattern/)) {
-               return 0;
-       }
-
-       if ($config_format) {
-               print "# ";
-       }
-       print "$pr_flags : ";
-
-       return 1;
+	# return 1 if anything printed, else 0
+
+	# some fields of pn_arg_ref might not be used in this function, but
+	# extract all of them anyway.
+	my $pn_arg_ref		= shift;
+
+	my $compat		= $pn_arg_ref->{compat};
+	my $compatible_cnt	= $pn_arg_ref->{compatible_cnt};
+	my $config		= $pn_arg_ref->{config};
+	my $config_cnt		= $pn_arg_ref->{config_cnt};
+	my $driver		= $pn_arg_ref->{driver};
+	my $driver_cnt		= $pn_arg_ref->{driver_cnt};
+	my $full_node		= $pn_arg_ref->{full_node};
+	my $node		= $pn_arg_ref->{node};
+	my $node_enabled	= $pn_arg_ref->{node_enabled};
+	my $white_list		= $pn_arg_ref->{white_list};
+
+	my $pr_flags		= '-' x $num_pr_flags;
+
+
+	# ----- set flags in $pr_flags
+
+	if ($compatible_cnt > 1) {
+		&set_flag(\$pr_flags, $pr_flag_pos_mcompatible);
+	}
+
+	if ($config_cnt > 1) {
+		&set_flag(\$pr_flags, $pr_flag_pos_mconfig);
+	}
+
+	if ($driver_cnt >= 1) {
+		&set_flag(\$pr_flags, $pr_flag_pos_driver);
+	}
+
+	if ($driver_cnt > 1) {
+		&set_flag(\$pr_flags, $pr_flag_pos_mdriver);
+	}
+
+	# These strings are the same way the linux kernel tests.
+	# The ePapr lists of values is slightly different.
+	if (!(($node_enabled eq "") ||
+	      ($node_enabled eq "ok") ||
+	      ($node_enabled eq "okay"))) {
+		&set_flag(\$pr_flags, $pr_flag_pos_node_not_enabled);
+	}
+
+	if ($white_list) {
+		&set_flag(\$pr_flags, $pr_flag_pos_white_list);
+	}
+
+	if (exists($driver_hard_code_list{$compat}) ||
+	    (exists($driver_config_hard_code_list{$driver}) &&
+	     ($driver ne "no_driver"))) {
+		&set_flag(\$pr_flags, $pr_flag_pos_hard_coded);
+	}
+
+	my @configs = split(' && ', $config);
+	for $configs (@configs) {
+		$not = $configs =~ /^!/;
+		$configs =~ s/^!//;
+
+		if (($configs ne "no_config") && ($configs ne "no_makefile")) {
+			&set_flag(\$pr_flags, $pr_flag_pos_config);
+		}
+
+		if (($config_cnt >= 1) &&
+		    ($configs !~ /CONFIG_/) &&
+		    (($configs ne "no_config") && ($configs ne "no_makefile"))) {
+			&set_flag(\$pr_flags, $pr_flag_pos_config_hard_coded);
+		}
+
+		my $existing_config = $existing_config{$configs};
+		if ($existing_config eq "m") {
+			&set_flag(\$pr_flags, $pr_flag_pos_config_m);
+			# Possible fail, depends on whether built in or
+			# module is desired.
+			&set_flag(\$pr_flags, $pr_flag_pos_config_test_fail);
+		} elsif ($existing_config eq "y") {
+			&set_flag(\$pr_flags, $pr_flag_pos_config_y);
+			if ($not) {
+				&set_flag(\$pr_flags, $pr_flag_pos_config_test_fail);
+			}
+		} elsif (($config_file) && ($configs =~ /CONFIG_/)) {
+			&set_flag(\$pr_flags, $pr_flag_pos_config_none);
+			if (!$not) {
+				&set_flag(\$pr_flags, $pr_flag_pos_config_test_fail);
+			}
+		}
+	}
+
+	# ----- include / exclude filters
+
+	if ($include_flag_pattern && ($pr_flags !~ m/$include_flag_pattern/)) {
+		return 0;
+	}
+
+	if ($exclude_flag_pattern && ($pr_flags =~ m/$exclude_flag_pattern/)) {
+		return 0;
+	}
+
+	if ($config_format) {
+		print "# ";
+	}
+	print "$pr_flags : ";
+
+	return 1;
 }
 
 
 sub print_node()
 {
-       # return number of lines printed
-
-       # some fields of pn_arg_ref might not be used in this function, but
-       # extract all of them anyway.
-       my $pn_arg_ref     = shift;
-
-       my $compat         = $pn_arg_ref->{compat};
-       my $compatible_cnt = $pn_arg_ref->{compatible_cnt};
-       my $config         = $pn_arg_ref->{config};
-       my $config_cnt     = $pn_arg_ref->{config_cnt};
-       my $driver         = $pn_arg_ref->{driver};
-       my $driver_cnt     = $pn_arg_ref->{driver_cnt};
-       my $full_node      = $pn_arg_ref->{full_node};
-       my $node           = $pn_arg_ref->{node};
-       my $node_enabled   = $pn_arg_ref->{node_enabled};
-       my $white_list     = $pn_arg_ref->{white_list};
-
-       my $separator;
-
-       if (! &print_flags($pn_arg_ref)) {
-               return 0;
-       }
-
-
-       if ($short_name) {
-               print "$node";
-       } else {
-               print "$full_node";
-       }
-       print " : $compat : $driver : $config : ";
-
-       my @configs = split(' && ', $config);
-
-       if ($config_file) {
-               for $configs (@configs) {
-                       $configs =~ s/^!//;
-                       my $existing_config = $existing_config{$configs};
-                       if (!$existing_config) {
-                               # check for /-m/, /-y/, or /-objs/
-                               if ($configs !~ /CONFIG_/) {
-                                       $existing_config = "x";
-                               };
-                       };
-                       if ($existing_config) {
-                               print "$separator", "$existing_config";
-                               $separator = ", ";
-                       } else {
-                               print "$separator", "n";
-                               $separator = ", ";
-                       }
-               }
-       } else {
-               print "none";
-       }
-
-       print "\n";
-
-       if ($config_format) {
-               for $configs (@configs) {
-                       $not = $configs =~ /^!/;
-                       $configs =~ s/^!//;
-                       my $existing_config = $existing_config{$configs};
-
-                       if ($not) {
-                               if ($configs !~ /CONFIG_/) {
-                                       print "# $configs\n";
-                               } elsif ($existing_config eq "m") {
-                                       print "# $configs is m\n";
-                                       print "# $configs=n\n";
-                               } elsif ($existing_config eq "y") {
-                                       print "# $configs is set\n";
-                                       print "# $configs=n\n";
-                               } else {
-                                       print "# $configs is not set\n";
-                                       print "# $configs=n\n";
-                               }
-
-                       } else {
-                               if ($configs !~ /CONFIG_/) {
-                                       print "# $configs\n";
-                               } elsif ($existing_config eq "m") {
-                                       print "# $configs is m\n";
-                                       print "# $configs=y\n";
-                               } elsif ($existing_config eq "y") {
-                                       print "# $configs is set\n";
-                                       print "# $configs=y\n";
-                               } else {
-                                       print "# $configs is not set\n";
-                                       print "# $configs=y\n";
-                               }
-                       }
-               }
-       }
-
-       return 1;
+	# return number of lines printed
+
+	# some fields of pn_arg_ref might not be used in this function, but
+	# extract all of them anyway.
+	my $pn_arg_ref		= shift;
+
+	my $compat		= $pn_arg_ref->{compat};
+	my $compatible_cnt	= $pn_arg_ref->{compatible_cnt};
+	my $config		= $pn_arg_ref->{config};
+	my $config_cnt		= $pn_arg_ref->{config_cnt};
+	my $driver		= $pn_arg_ref->{driver};
+	my $driver_cnt		= $pn_arg_ref->{driver_cnt};
+	my $full_node		= $pn_arg_ref->{full_node};
+	my $node		= $pn_arg_ref->{node};
+	my $node_enabled	= $pn_arg_ref->{node_enabled};
+	my $white_list		= $pn_arg_ref->{white_list};
+
+	my $separator;
+
+	if (! &print_flags($pn_arg_ref)) {
+		return 0;
+	}
+
+
+	if ($short_name) {
+		print "$node";
+	} else {
+		print "$full_node";
+	}
+	print " : $compat : $driver : $config : ";
+
+	my @configs = split(' && ', $config);
+
+	if ($config_file) {
+		for $configs (@configs) {
+			$configs =~ s/^!//;
+			my $existing_config = $existing_config{$configs};
+			if (!$existing_config) {
+				# check for /-m/, /-y/, or /-objs/
+				if ($configs !~ /CONFIG_/) {
+					$existing_config = "x";
+				};
+			};
+			if ($existing_config) {
+				print "$separator", "$existing_config";
+				$separator = ", ";
+			} else {
+				print "$separator", "n";
+				$separator = ", ";
+			}
+		}
+	} else {
+		print "none";
+	}
+
+	print "\n";
+
+	if ($config_format) {
+		for $configs (@configs) {
+			$not = $configs =~ /^!/;
+			$configs =~ s/^!//;
+			my $existing_config = $existing_config{$configs};
+
+			if ($not) {
+				if ($configs !~ /CONFIG_/) {
+					print "# $configs\n";
+				} elsif ($existing_config eq "m") {
+					print "# $configs is m\n";
+					print "# $configs=n\n";
+				} elsif ($existing_config eq "y") {
+					print "# $configs is set\n";
+					print "# $configs=n\n";
+				} else {
+					print "# $configs is not set\n";
+					print "# $configs=n\n";
+				}
+
+			} else {
+				if ($configs !~ /CONFIG_/) {
+					print "# $configs\n";
+				} elsif ($existing_config eq "m") {
+					print "# $configs is m\n";
+					print "# $configs=y\n";
+				} elsif ($existing_config eq "y") {
+					print "# $configs is set\n";
+					print "# $configs=y\n";
+				} else {
+					print "# $configs is not set\n";
+					print "# $configs=y\n";
+				}
+			}
+		}
+	}
+
+	return 1;
 }
 
 
 sub scan_makefile
 {
-       my $pn_arg_ref    = shift;
-       my $driver        = shift;
-
-       # ----- Find Kconfig symbols that enable driver
-
-       my ($dir, $base) = $driver =~ m{(.*)/(.*).c};
-
-       my $makefile = $dir . "/Makefile";
-       if (! -r $makefile) {
-               $makefile = $dir . "/Kbuild";
-       }
-       if (! -r $makefile) {
-               my $config;
-
-               $config = 'no_makefile';
-               push @{ $driver_config{$driver} }, $config;
-               return;
-       }
-
-       if (!open(MAKEFILE_FILE, "<", "$makefile")) {
-               return;
-       }
-
-       my $line;
-       my @config;
-       my @if_config;
-       my @make_var;
-
-       NEXT_LINE:
-       while ($next_line = <MAKEFILE_FILE>) {
-               my $config;
-               my $if_config;
-               my $ifdef;
-               my $ifeq;
-               my $ifndef;
-               my $ifneq;
-               my $ifdef_config;
-               my $ifeq_config;
-               my $ifndef_config;
-               my $ifneq_config;
-
-               chomp($next_line);
-               $line = $line . $next_line;
-               if ($next_line =~ /\\$/) {
-                       $line =~ s/\\$/ /;
-                       next NEXT_LINE;
-               }
-               if ($line =~ /^\s*#/) {
-                       $line = "";
-                       next NEXT_LINE;
-               }
-
-               # -----  condition ... else ... endif
-
-               if ($line =~ /^([ ]\s*|)else\b/) {
-                       $if_config = "!" . pop @if_config;
-                       $if_config =~ s/^!!//;
-                       push @if_config, $if_config;
-                       $line =~ s/^([ ]\s*|)else\b//;
-               }
-
-               ($null, $ifeq_config,  $ifeq_config_val )  = $line =~ /^([ ]\s*|)ifeq\b.*\b(CONFIG_[A-Za-z0-9_]*)(.*)/;
-               ($null, $ifneq_config, $ifneq_config_val)  = $line =~ /^([ ]\s*|)ifneq\b.*\b(CONFIG_[A-Za-z0-9_]*)(.*)/;
-               ($null, $ifdef_config)                     = $line =~ /^([ ]\s*|)ifdef\b.*\b(CONFIG_[A-Za-z0-9_]*)/;
-               ($null, $ifndef_config)                    = $line =~ /^([ ]\s*|)ifndef\b.*\b(CONFIG_[A-Za-z0-9_]*)/;
-
-               ($null, $ifeq)   = $line =~ /^([ ]\s*|)ifeq\b\s*(.*)/;
-               ($null, $ifneq)  = $line =~ /^([ ]\s*|)ifneq\b\s*(.*)/;
-               ($null, $ifdef)  = $line =~ /^([ ]\s*|)ifdef\b\s*(.*)/;
-               ($null, $ifndef) = $line =~ /^([ ]\s*|)ifndef\b\s*(.*)/;
-
-               # Order of tests is important.  Prefer "CONFIG_*" regex match over
-               # less specific regex match.
-               if ($ifdef_config) {
-                       $if_config = $ifdef_config;
-               } elsif ($ifeq_config) {
-                       if ($ifeq_config_val =~ /y/) {
-                               $if_config = $ifeq_config;
-                       } else {
-                               $if_config = "!" . $ifeq_config;
-                       }
-               } elsif ($ifndef_config) {
-                       $if_config = "!" . $ifndef_config;
-               } elsif ($ifneq_config) {
-                       if ($ifneq_config_val =~ /y/) {
-                               $if_config = "!" . $ifneq_config;
-                       } else {
-                               $if_config = $ifneq_config;
-                       }
-               } elsif ($ifdef) {
-                       $if_config = $ifdef;
-               } elsif ($ifeq) {
-                       $if_config = $ifeq;
-               } elsif ($ifndef) {
-                       $if_config = "!" . $ifndef;
-               } elsif ($ifneq) {
-                       $if_config = "!" . $ifneq;
-               } else {
-                       $if_config = "";
-               }
-               $if_config =~ s/^!!//;
-
-               if ($if_config) {
-                       push @if_config, $if_config;
-                       $line = "";
-                       next NEXT_LINE;
-               }
-
-               if ($line =~ /^([ ]\s*|)endif\b/) {
-                       pop @if_config;
-                       $line = "";
-                       next NEXT_LINE;
-               }
-
-               # ----- simple CONFIG_* = *.[co]  or  xxx [+:?]*= *.[co]
-               # Most makefiles select on *.o, but
-               # arch/powerpc/boot/Makefile selects on *.c
-
-               ($config) = $line =~ /(CONFIG_[A-Za-z0-9_]+).*\b$base.[co]\b/;
-
-               # ----- match a make variable instead of *.[co]
-               # Recursively expanded variables are not handled.
-
-               if (!$config) {
-                       my $make_var;
-                       ($make_var) = $line =~ /\s*(\S+?)\s*[+:\?]*=.*\b$base.[co]\b/;
-                       if ($make_var) {
-                               if ($make_var =~ /[a-zA-Z0-9]+-[ym]/) {
-                                       $config = $make_var;
-                               } elsif ($make_var =~ /[a-zA-Z0-9]+-objs/) {
-                                       $config = $make_var;
-                               } else {
-                                       push @make_var, $make_var;
-                               }
-                       }
-               }
-
-               if (!$config) {
-                       for $make_var (@make_var) {
-                               ($config) = $line =~ /(CONFIG_[A-Za-z0-9_]+).*\b$make_var\b/;
-                               last if ($config);
-                       }
-               }
-
-               if (!$config) {
-                       for $make_var (@make_var) {
-                               ($config) = $line =~ /\s*(\S+?)\s*[+:\?]*=.*\b$make_var\b/;
-                               last if ($config);
-                       }
-               }
-
-               # ----- next if no config found
-
-               if (!$config) {
-                       $line = "";
-                       next NEXT_LINE;
-               }
-
-               for $if_config (@if_config) {
-                       $config = $if_config . " && " . $config;
-               }
-
-               push @{ $driver_config{$driver} }, $config;
-
-               $line = "";
-       }
-
-       close(MAKEFILE_FILE);
-
+	my $pn_arg_ref	= shift;
+	my $driver	= shift;
+
+	# ----- Find Kconfig symbols that enable driver
+
+	my ($dir, $base) = $driver =~ m{(.*)/(.*).c};
+
+	my $makefile = $dir . "/Makefile";
+	if (! -r $makefile) {
+		$makefile = $dir . "/Kbuild";
+	}
+	if (! -r $makefile) {
+		my $config;
+
+		$config = 'no_makefile';
+		push @{ $driver_config{$driver} }, $config;
+		return;
+	}
+
+	if (!open(MAKEFILE_FILE, "<", "$makefile")) {
+		return;
+	}
+
+	my $line;
+	my @config;
+	my @if_config;
+	my @make_var;
+
+	NEXT_LINE:
+	while ($next_line = <MAKEFILE_FILE>) {
+		my $config;
+		my $if_config;
+		my $ifdef;
+		my $ifeq;
+		my $ifndef;
+		my $ifneq;
+		my $ifdef_config;
+		my $ifeq_config;
+		my $ifndef_config;
+		my $ifneq_config;
+
+		chomp($next_line);
+		$line = $line . $next_line;
+		if ($next_line =~ /\\$/) {
+			$line =~ s/\\$/ /;
+			next NEXT_LINE;
+		}
+		if ($line =~ /^\s*#/) {
+			$line = "";
+			next NEXT_LINE;
+		}
+
+		# -----  condition ... else ... endif
+
+		if ($line =~ /^([ ]\s*|)else\b/) {
+			$if_config = "!" . pop @if_config;
+			$if_config =~ s/^!!//;
+			push @if_config, $if_config;
+			$line =~ s/^([ ]\s*|)else\b//;
+		}
+
+		($null, $ifeq_config,  $ifeq_config_val ) = $line =~ /^([ ]\s*|)ifeq\b.*\b(CONFIG_[A-Za-z0-9_]*)(.*)/;
+		($null, $ifneq_config, $ifneq_config_val) = $line =~ /^([ ]\s*|)ifneq\b.*\b(CONFIG_[A-Za-z0-9_]*)(.*)/;
+		($null, $ifdef_config)			  = $line =~ /^([ ]\s*|)ifdef\b.*\b(CONFIG_[A-Za-z0-9_]*)/;
+		($null, $ifndef_config)			  = $line =~ /^([ ]\s*|)ifndef\b.*\b(CONFIG_[A-Za-z0-9_]*)/;
+
+		($null, $ifeq)   = $line =~ /^([ ]\s*|)ifeq\b\s*(.*)/;
+		($null, $ifneq)  = $line =~ /^([ ]\s*|)ifneq\b\s*(.*)/;
+		($null, $ifdef)  = $line =~ /^([ ]\s*|)ifdef\b\s*(.*)/;
+		($null, $ifndef) = $line =~ /^([ ]\s*|)ifndef\b\s*(.*)/;
+
+		# Order of tests is important.  Prefer "CONFIG_*" regex match over
+		# less specific regex match.
+		if ($ifdef_config) {
+			$if_config = $ifdef_config;
+		} elsif ($ifeq_config) {
+			if ($ifeq_config_val =~ /y/) {
+				$if_config = $ifeq_config;
+			} else {
+				$if_config = "!" . $ifeq_config;
+			}
+		} elsif ($ifndef_config) {
+			$if_config = "!" . $ifndef_config;
+		} elsif ($ifneq_config) {
+			if ($ifneq_config_val =~ /y/) {
+				$if_config = "!" . $ifneq_config;
+			} else {
+				$if_config = $ifneq_config;
+			}
+		} elsif ($ifdef) {
+			$if_config = $ifdef;
+		} elsif ($ifeq) {
+			$if_config = $ifeq;
+		} elsif ($ifndef) {
+			$if_config = "!" . $ifndef;
+		} elsif ($ifneq) {
+			$if_config = "!" . $ifneq;
+		} else {
+			$if_config = "";
+		}
+		$if_config =~ s/^!!//;
+
+		if ($if_config) {
+			push @if_config, $if_config;
+			$line = "";
+			next NEXT_LINE;
+		}
+
+		if ($line =~ /^([ ]\s*|)endif\b/) {
+			pop @if_config;
+			$line = "";
+			next NEXT_LINE;
+		}
+
+		# ----- simple CONFIG_* = *.[co]  or  xxx [+:?]*= *.[co]
+		# Most makefiles select on *.o, but
+		# arch/powerpc/boot/Makefile selects on *.c
+
+		($config) = $line =~ /(CONFIG_[A-Za-z0-9_]+).*\b$base.[co]\b/;
+
+		# ----- match a make variable instead of *.[co]
+		# Recursively expanded variables are not handled.
+
+		if (!$config) {
+			my $make_var;
+			($make_var) = $line =~ /\s*(\S+?)\s*[+:\?]*=.*\b$base.[co]\b/;
+			if ($make_var) {
+				if ($make_var =~ /[a-zA-Z0-9]+-[ym]/) {
+					$config = $make_var;
+				} elsif ($make_var =~ /[a-zA-Z0-9]+-objs/) {
+					$config = $make_var;
+				} else {
+					push @make_var, $make_var;
+				}
+			}
+		}
+
+		if (!$config) {
+			for $make_var (@make_var) {
+				($config) = $line =~ /(CONFIG_[A-Za-z0-9_]+).*\b$make_var\b/;
+				last if ($config);
+			}
+		}
+
+		if (!$config) {
+			for $make_var (@make_var) {
+				($config) = $line =~ /\s*(\S+?)\s*[+:\?]*=.*\b$make_var\b/;
+				last if ($config);
+			}
+		}
+
+		# ----- next if no config found
+
+		if (!$config) {
+			$line = "";
+			next NEXT_LINE;
+		}
+
+		for $if_config (@if_config) {
+			$config = $if_config . " && " . $config;
+		}
+
+		push @{ $driver_config{$driver} }, $config;
+
+		$line = "";
+	}
+
+	close(MAKEFILE_FILE);
 }
 
 
 sub find_kconfig
 {
-       my $pn_arg_ref    = shift;
-       my $driver        = shift;
+	my $pn_arg_ref	= shift;
+	my $driver	= shift;
 
-       my $lines_printed = 0;
-       my @configs;
+	my $lines_printed = 0;
+	my @configs;
 
-       if (!@{ $driver_config{$driver} }) {
-               &scan_makefile($pn_arg_ref, $driver);
-               if (!@{ $driver_config{$driver} }) {
-                       push @{ $driver_config{$driver} }, "no_config";
-               }
-       }
+	if (!@{ $driver_config{$driver} }) {
+		&scan_makefile($pn_arg_ref, $driver);
+		if (!@{ $driver_config{$driver} }) {
+			push @{ $driver_config{$driver} }, "no_config";
+		}
+	}
 
-       @configs = @{ $driver_config{$driver} };
+	@configs = @{ $driver_config{$driver} };
 
-       $$pn_arg_ref{config_cnt} = $#configs + 1;
-       for my $config (@configs) {
-               $$pn_arg_ref{config} = $config;
-               $lines_printed += &print_node($pn_arg_ref);
-       }
+	$$pn_arg_ref{config_cnt} = $#configs + 1;
+	for my $config (@configs) {
+		$$pn_arg_ref{config} = $config;
+		$lines_printed += &print_node($pn_arg_ref);
+	}
 
-       return $lines_printed;
+	return $lines_printed;
 }
 
 
 sub handle_compatible()
 {
-       my $full_node     = shift;
-       my $node          = shift;
-       my $compatible    = shift;
-       my $node_enabled  = shift;
-
-       my $compat;
-       my $lines_printed = 0;
-       my %pn_arg        = ();
-
-       return if (!$node or !$compatible);
-
-       # Do not process compatible property of root node,
-       # it is used to match board, not to bind a driver.
-       return if ($node eq "/");
-
-       $pn_arg{full_node}    = $full_node;
-       $pn_arg{node}         = $node;
-       $pn_arg{node_enabled} = $node_enabled;
-
-       $compatible =~ s/\\0/", "/g;
-       my @compatibles = split('", "', $compatible);
-
-       $compatibles[0] =~ s/^"//;
-       $compatibles[$#compatibles] =~ s/"$//;
-
-       $pn_arg{compatible_cnt} = $#compatibles + 1;
-
-       COMPAT:
-       for $compat (@compatibles) {
-
-               $pn_arg{compat}     = $compat;
-               $pn_arg{driver_cnt} = 0;
-               $pn_arg{white_list} = 0;
-
-               if (exists($compat_white_list{$compat})) {
-                       $pn_arg{white_list} = 1;
-                       $pn_arg{driver}     = "no_driver";
-                       $pn_arg{config_cnt} = 1;
-                       $pn_arg{config}     = "no_config";
-                       $lines_printed += &print_node(\%pn_arg);
-                       next COMPAT;
-               }
-
-               # ----- if compat previously seen, use cached info
-
-               if (exists($compat_driver{$compat})) {
-                       for my $driver (@{ $compat_driver{$compat} }) {
-                               $pn_arg{driver}     = $driver;
-                               $pn_arg{driver_cnt} = $driver_count{$compat};
-                               $pn_arg{config_cnt} = $#{ $driver_config{$driver}} + 1;
-
-                               for my $config (@{ $driver_config{$driver} }) {
-                                       $pn_arg{config} = $config;
-                                       $lines_printed += &print_node(\%pn_arg);
-                               }
-
-                               if (!@{ $driver_config{$driver} }) {
-                                       # no config cached yet
-                                       # $driver in %driver_hard_code_list
-                                       # but not %driver_config_hard_code_list
-                                       $lines_printed += &find_kconfig(\%pn_arg, $driver);
-                               }
-                       }
-                       next COMPAT;
-               }
-
-
-               # ----- Find drivers (source files that contain compatible)
-
-               # this will miss arch/sparc/include/asm/parport.h
-               # It is better to move the compatible out of the .h
-               # than to add *.h. to the files list, because *.h generates
-               # a lot of false negatives.
-               my $files = '"*.c"';
-               my $drivers = `git grep -l '"$compat"' -- $files`;
-               chomp($drivers);
-               if ($drivers eq "") {
-                       $pn_arg{driver} = "no_driver";
-                       $pn_arg{config_cnt} = 1;
-                       $pn_arg{config} = "no_config";
-                       push @{ $compat_driver{$compat} }, "no_driver";
-                       $lines_printed += &print_node(\%pn_arg);
-                       next COMPAT;
-               }
-
-               my @drivers = split("\n", $drivers);
-               $driver_count{$compat} = $#drivers + 1;
-               $pn_arg{driver_cnt}    = $#drivers + 1;
-
-               DRIVER:
-               for my $driver (@drivers) {
-                       push @{ $compat_driver{$compat} }, $driver;
-                       $pn_arg{driver} = $driver;
-
-                       # ----- if driver previously seen, use cached info
-
-                       $pn_arg{config_cnt} = $#{ $driver_config{$driver} } + 1;
-                       for my $config (@{ $driver_config{$driver} }) {
-                               $pn_arg{config} = $config;
-                               $lines_printed += &print_node(\%pn_arg);
-                       }
-                       if (@{ $driver_config{$driver} }) {
-                               next DRIVER;
-                       }
-
-                       if ($black_list_driver) {
-                               for $black (@black_list_driver) {
-                                       next DRIVER if ($driver =~ /^$black$/);
-                               }
-                       }
-
-
-                       # ----- Find Kconfig symbols that enable driver
-
-                       $lines_printed += &find_kconfig(\%pn_arg, $driver);
-
-               }
-       }
-
-       # White space (line) between nodes for readability.
-       # Each node may report several compatibles.
-       # For each compatible, multiple drivers may be reported.
-       # For each driver, multiple CONFIG_ options may be reported.
-       if ($lines_printed) {
-               print "\n";
-       }
+	my $full_node		= shift;
+	my $node		= shift;
+	my $compatible		= shift;
+	my $node_enabled	= shift;
+
+	my $compat;
+	my $lines_printed	= 0;
+	my %pn_arg		= ();
+
+	return if (!$node or !$compatible);
+
+	# Do not process compatible property of root node,
+	# it is used to match board, not to bind a driver.
+	return if ($node eq "/");
+
+	$pn_arg{full_node}	= $full_node;
+	$pn_arg{node}		= $node;
+	$pn_arg{node_enabled}	= $node_enabled;
+
+	$compatible =~ s/\\0/", "/g;
+	my @compatibles = split('", "', $compatible);
+
+	$compatibles[0] =~ s/^"//;
+	$compatibles[$#compatibles] =~ s/"$//;
+
+	$pn_arg{compatible_cnt} = $#compatibles + 1;
+
+	COMPAT:
+	for $compat (@compatibles) {
+
+		$pn_arg{compat}		= $compat;
+		$pn_arg{driver_cnt}	= 0;
+		$pn_arg{white_list}	= 0;
+
+		if (exists($compat_white_list{$compat})) {
+			$pn_arg{white_list}	= 1;
+			$pn_arg{driver}		= "no_driver";
+			$pn_arg{config_cnt}	= 1;
+			$pn_arg{config}		= "no_config";
+			$lines_printed += &print_node(\%pn_arg);
+			next COMPAT;
+		}
+
+		# ----- if compat previously seen, use cached info
+
+		if (exists($compat_driver{$compat})) {
+			for my $driver (@{ $compat_driver{$compat} }) {
+				$pn_arg{driver}		= $driver;
+				$pn_arg{driver_cnt}	= $driver_count{$compat};
+				$pn_arg{config_cnt}	= $#{ $driver_config{$driver}} + 1;
+
+				for my $config (@{ $driver_config{$driver} }) {
+					$pn_arg{config} = $config;
+					$lines_printed += &print_node(\%pn_arg);
+				}
+
+				if (!@{ $driver_config{$driver} }) {
+					# no config cached yet
+					# $driver in %driver_hard_code_list
+					# but not %driver_config_hard_code_list
+					$lines_printed += &find_kconfig(\%pn_arg, $driver);
+				}
+			}
+			next COMPAT;
+		}
+
+
+		# ----- Find drivers (source files that contain compatible)
+
+		# this will miss arch/sparc/include/asm/parport.h
+		# It is better to move the compatible out of the .h
+		# than to add *.h. to the files list, because *.h generates
+		# a lot of false negatives.
+		my $files = '"*.c"';
+		my $drivers = `git grep -l '"$compat"' -- $files`;
+		chomp($drivers);
+		if ($drivers eq "") {
+			$pn_arg{driver} = "no_driver";
+			$pn_arg{config_cnt} = 1;
+			$pn_arg{config} = "no_config";
+			push @{ $compat_driver{$compat} }, "no_driver";
+			$lines_printed += &print_node(\%pn_arg);
+			next COMPAT;
+		}
+
+		my @drivers = split("\n", $drivers);
+		$driver_count{$compat}	= $#drivers + 1;
+		$pn_arg{driver_cnt}	= $#drivers + 1;
+
+		DRIVER:
+		for my $driver (@drivers) {
+			push @{ $compat_driver{$compat} }, $driver;
+			$pn_arg{driver} = $driver;
+
+			# ----- if driver previously seen, use cached info
+
+			$pn_arg{config_cnt} = $#{ $driver_config{$driver} } + 1;
+			for my $config (@{ $driver_config{$driver} }) {
+				$pn_arg{config} = $config;
+				$lines_printed += &print_node(\%pn_arg);
+			}
+			if (@{ $driver_config{$driver} }) {
+				next DRIVER;
+			}
+
+			if ($black_list_driver) {
+				for $black (@black_list_driver) {
+					next DRIVER if ($driver =~ /^$black$/);
+				}
+			}
+
+
+			# ----- Find Kconfig symbols that enable driver
+
+			$lines_printed += &find_kconfig(\%pn_arg, $driver);
+
+		}
+	}
+
+	# White space (line) between nodes for readability.
+	# Each node may report several compatibles.
+	# For each compatible, multiple drivers may be reported.
+	# For each driver, multiple CONFIG_ options may be reported.
+	if ($lines_printed) {
+		print "\n";
+	}
 }
 
 sub read_dts()
 {
-       my $file         = shift;
-
-       my $compatible   = "";
-       my $line;
-       my $node         = "";
-       my $node_enabled = "";
-
-       if (! -r $file) {
-               print STDERR "file '$file' is not readable or does not exist\n";
-               exit 3;
-       }
-
-       if (!open(DT_FILE, "-|", "$dtx_diff $file")) {
-               print STDERR "\n";
-               print STDERR "shell command failed:\n";
-               print STDERR "   $dtx_diff $file\n";
-               print STDERR "\n";
-               exit 3;
-       }
-
-       FILE:
-       while ($line = <DT_FILE>) {
-               chomp($line);
-
-               if ($line =~ /{/) {
-
-                       &handle_compatible($full_node, $node, $compatible,
-                                          $node_enabled);
-
-                       while ($end_node_count-- > 0) {
-                               pop @full_node;
-                       };
-                       $end_node_count = 0;
-                       $full_node = @full_node[-1];
-
-                       $node = $line;
-                       $node =~ s/^\s*(.*)\s+\{.*/$1/;
-                       $node =~ s/.*: //;
-                       if ($node eq '/' ) {
-                               $full_node = '/';
-                       } elsif ($full_node ne '/') {
-                               $full_node = $full_node . '/' . $node;
-                       } else {
-                               $full_node = '/' . $node;
-                       }
-                       push @full_node, $full_node;
-
-                       $compatible = "";
-                       $node_enabled = "";
-                       next FILE;
-               }
-
-               if ($line =~ /}/) {
-                       $end_node_count++;
-               }
-
-               if ($line =~ /(\s+|^)status =/) {
-                       $node_enabled = $line;
-                       $node_enabled =~ s/^\t*//;
-                       $node_enabled =~ s/^status = "//;
-                       $node_enabled =~ s/";$//;
-                       next FILE;
-               }
-
-               if ($line =~ /(\s+|^)compatible =/) {
-                       # Extract all compatible entries for this device
-                       # White space matching here and in handle_compatible() is
-                       # precise, because input format is the output of dtc,
-                       # which is invoked by dtx_diff.
-                       $compatible = $line;
-                       $compatible =~ s/^\t*//;
-                       $compatible =~ s/^compatible = //;
-                       $compatible =~ s/;$//;
-               }
-       }
-
-       &handle_compatible($full_node, $node, $compatible, $node_enabled);
-
-       close(DT_FILE);
+	my $file		= shift;
+
+	my $compatible		= "";
+	my $line;
+	my $node		= "";
+	my $node_enabled	= "";
+
+	if (! -r $file) {
+		print STDERR "file '$file' is not readable or does not exist\n";
+		exit 3;
+	}
+
+	if (!open(DT_FILE, "-|", "$dtx_diff $file")) {
+		print STDERR "\n";
+		print STDERR "shell command failed:\n";
+		print STDERR "   $dtx_diff $file\n";
+		print STDERR "\n";
+		exit 3;
+	}
+
+	FILE:
+	while ($line = <DT_FILE>) {
+		chomp($line);
+
+		if ($line =~ /{/) {
+
+			&handle_compatible($full_node, $node, $compatible,
+					   $node_enabled);
+
+			while ($end_node_count-- > 0) {
+				pop @full_node;
+			};
+			$end_node_count = 0;
+			$full_node = @full_node[-1];
+
+			$node = $line;
+			$node =~ s/^\s*(.*)\s+\{.*/$1/;
+			$node =~ s/.*: //;
+			if ($node eq '/' ) {
+				$full_node = '/';
+			} elsif ($full_node ne '/') {
+				$full_node = $full_node . '/' . $node;
+			} else {
+				$full_node = '/' . $node;
+			}
+			push @full_node, $full_node;
+
+			$compatible = "";
+			$node_enabled = "";
+			next FILE;
+		}
+
+		if ($line =~ /}/) {
+			$end_node_count++;
+		}
+
+		if ($line =~ /(\s+|^)status =/) {
+			$node_enabled = $line;
+			$node_enabled =~ s/^\t*//;
+			$node_enabled =~ s/^status = "//;
+			$node_enabled =~ s/";$//;
+			next FILE;
+		}
+
+		if ($line =~ /(\s+|^)compatible =/) {
+			# Extract all compatible entries for this device
+			# White space matching here and in handle_compatible() is
+			# precise, because input format is the output of dtc,
+			# which is invoked by dtx_diff.
+			$compatible = $line;
+			$compatible =~ s/^\t*//;
+			$compatible =~ s/^compatible = //;
+			$compatible =~ s/;$//;
+		}
+	}
+
+	&handle_compatible($full_node, $node, $compatible, $node_enabled);
+
+	close(DT_FILE);
 }
 
 
 sub read_config_file()
 {
-       if (! -r $config_file) {
-               print STDERR "file '$config_file' is not readable or does not exist\n";
-               exit 2;
-       }
-
-       if (!open(CONFIG_FILE, "<", "$config_file")) {
-               print STDERR "open $config_file failed\n";
-               exit 2;
-       }
-
-       my @line;
-
-       LINE:
-       while ($line = <CONFIG_FILE>) {
-               chomp($line);
-               next LINE if ($line =~ /^\s*#/);
-               next LINE if ($line =~ /^\s*$/);
-               @line = split /=/, $line;
-               $existing_config{@line[0]} = @line[1];
-       }
-
-       close(CONFIG_FILE);
+	if (! -r $config_file) {
+		print STDERR "file '$config_file' is not readable or does not exist\n";
+		exit 2;
+	}
+
+	if (!open(CONFIG_FILE, "<", "$config_file")) {
+		print STDERR "open $config_file failed\n";
+		exit 2;
+	}
+
+	my @line;
+
+	LINE:
+	while ($line = <CONFIG_FILE>) {
+		chomp($line);
+		next LINE if ($line =~ /^\s*#/);
+		next LINE if ($line =~ /^\s*$/);
+		@line = split /=/, $line;
+		$existing_config{@line[0]} = @line[1];
+	}
+
+	close(CONFIG_FILE);
 }
 
 
 sub cmd_line_err()
 {
-       my $msg = shift;
-
-       print STDERR "\n";
-       print STDERR "   ERROR processing command line options\n";
-       print STDERR "         $msg\n" if ($msg ne "");
-       print STDERR "\n";
-       print STDERR "   For help, type '$script_name --help'\n";
-       print STDERR "\n";
+	my $msg = shift;
+
+	print STDERR "\n";
+	print STDERR "   ERROR processing command line options\n";
+	print STDERR "         $msg\n" if ($msg ne "");
+	print STDERR "\n";
+	print STDERR "   For help, type '$script_name --help'\n";
+	print STDERR "\n";
 }
 
 
@@ -987,125 +984,121 @@ sub cmd_line_err()
 Getopt::Long::Configure("no_ignore_case", "bundling");
 
 if (!GetOptions(
-       "c=s"               => \$config_file,
-       "config=s"          => \$config_file,
-       "config-format"     => \$config_format,
-       "exclude-flag=s"    => \@exclude_flag,
-       "h"                 => \$help,
-       "help"              => \$help,
-       "black-list-driver" => \$black_list_driver,
-       "white-list-config" => \$white_list_config,
-       "white-list-driver" => \$white_list_driver,
-       "include-flag=s"    => \@include_flag,
-       "include-suspect"   => \$include_suspect,
-       "short-name"        => \$short_name,
-       "show-lists"        => \$show_lists,
-       "version"           => \$version,
-       )) {
-
-       &cmd_line_err();
-
-       exit 1;
+	"c=s"			=> \$config_file,
+	"config=s"		=> \$config_file,
+	"config-format"		=> \$config_format,
+	"exclude-flag=s"	=> \@exclude_flag,
+	"h"			=> \$help,
+	"help"			=> \$help,
+	"black-list-driver"	=> \$black_list_driver,
+	"white-list-config"	=> \$white_list_config,
+	"white-list-driver"	=> \$white_list_driver,
+	"include-flag=s"	=> \@include_flag,
+	"include-suspect"	=> \$include_suspect,
+	"short-name"		=> \$short_name,
+	"show-lists"		=> \$show_lists,
+	"version"		=> \$version,
+	)) {
+
+	&cmd_line_err();
+
+	exit 1;
 }
 
 
 my $exit_after_messages = 0;
 
 if ($version) {
-       print STDERR "\n$script_name  $VUFX\n\n";
-       $exit_after_messages = 1;
+	print STDERR "\n$script_name  $VUFX\n\n";
+	$exit_after_messages = 1;
 }
 
 
 if ($help) {
-       &usage;
-       $exit_after_messages = 1;
+	&usage;
+	$exit_after_messages = 1;
 }
 
 
 if ($show_lists) {
-
-       print "\n";
-       print "These compatibles are hard coded to have no driver.\n";
-       print "\n";
-       for my $compat (sort keys %compat_white_list) {
-               print "   $compat\n";
-       }
-
-
-       print "\n\n";
-       print "The driver for these compatibles is hard coded (white list).\n";
-       print "\n";
-       my $max_compat_len = 0;
-       for my $compat (sort keys %driver_hard_code_list) {
-               if (length $compat > $max_compat_len) {
-                       $max_compat_len = length $compat;
-               }
-       }
-       for my $compat (sort keys %driver_hard_code_list) {
-               if (($driver ne "hardcoded_no_driver") && ($driver ne "no_driver")) {
-                       my $first = 1;
-                       for my $driver (@{ $driver_hard_code_list{$compat} }) {
-                               if ($first) {
-                                       print "   $compat";
-                                       print " " x ($max_compat_len - length $compat);
-                                       $first = 0;
-                               } else {
-                                       print "   ", " " x $max_compat_len;
-                               }
-                               print "  $driver\n";
-                       }
-               }
-       }
-
-
-       print "\n\n";
-       print "The configuration option for these drivers is hard coded (white list).\n";
-       print "\n";
-       my $max_driver_len = 0;
-       for my $driver (sort keys %driver_config_hard_code_list) {
-               if (length $driver > $max_driver_len) {
-                       $max_driver_len = length $driver;
-               }
-       }
-       for my $driver (sort keys %driver_config_hard_code_list) {
-               if (($driver ne "hardcoded_no_driver") && ($driver ne "no_driver")) {
-                       my $first = 1;
-                       for my $config (@{ $driver_config_hard_code_list{$driver} }) {
-                               if ($first) {
-                                       print "   $driver";
-                                       print " " x ($max_driver_len - length $driver);
-                                       $first = 0;
-                               } else {
-                                       print "   ", " " x $max_driver_len;
-                               }
-                               print "  $config\n";
-                       }
-               }
-       }
-
-
-       print "\n\n";
-       print "These drivers are black listed.\n";
-       print "\n";
-       for my $driver (@black_list_driver) {
-               print "   $driver\n";
-       }
-
-       print "\n";
-
-       $exit_after_messages = 1;
+	print "\n";
+	print "These compatibles are hard coded to have no driver.\n";
+	print "\n";
+	for my $compat (sort keys %compat_white_list) {
+		print "   $compat\n";
+	}
+
+	print "\n\n";
+	print "The driver for these compatibles is hard coded (white list).\n";
+	print "\n";
+	my $max_compat_len = 0;
+	for my $compat (sort keys %driver_hard_code_list) {
+		if (length $compat > $max_compat_len) {
+			$max_compat_len = length $compat;
+		}
+	}
+	for my $compat (sort keys %driver_hard_code_list) {
+		if (($driver ne "hardcoded_no_driver") && ($driver ne "no_driver")) {
+			my $first = 1;
+			for my $driver (@{ $driver_hard_code_list{$compat} }) {
+				if ($first) {
+					print "   $compat";
+					print " " x ($max_compat_len - length $compat);
+					$first = 0;
+				} else {
+					print "   ", " " x $max_compat_len;
+				}
+				print "  $driver\n";
+			}
+		}
+	}
+
+	print "\n\n";
+	print "The configuration option for these drivers is hard coded (white list).\n";
+	print "\n";
+	my $max_driver_len = 0;
+	for my $driver (sort keys %driver_config_hard_code_list) {
+		if (length $driver > $max_driver_len) {
+			$max_driver_len = length $driver;
+		}
+	}
+	for my $driver (sort keys %driver_config_hard_code_list) {
+		if (($driver ne "hardcoded_no_driver") && ($driver ne "no_driver")) {
+			my $first = 1;
+			for my $config (@{ $driver_config_hard_code_list{$driver} }) {
+				if ($first) {
+					print "   $driver";
+					print " " x ($max_driver_len - length $driver);
+					$first = 0;
+				} else {
+					print "   ", " " x $max_driver_len;
+				}
+				print "  $config\n";
+			}
+		}
+	}
+
+	print "\n\n";
+	print "These drivers are black listed.\n";
+	print "\n";
+	for my $driver (@black_list_driver) {
+		print "   $driver\n";
+	}
+
+	print "\n";
+
+	$exit_after_messages = 1;
 }
 
 
 if ($exit_after_messages) {
-       exit 0;
+	exit 0;
 }
 
 
 $exclude_flag_pattern = "[";
 for my $exclude_flag (@exclude_flag) {
-       $exclude_flag_pattern = $exclude_flag_pattern . $exclude_flag;
+	$exclude_flag_pattern = $exclude_flag_pattern . $exclude_flag;
 }
 $exclude_flag_pattern = $exclude_flag_pattern . "]";
 # clean up if empty
@@ -1114,7 +1107,7 @@ $exclude_flag_pattern =~ s/^\[\]$//;
 
 $include_flag_pattern = "[";
 for my $include_flag (@include_flag) {
-       $include_flag_pattern = $include_flag_pattern . $include_flag;
+	$include_flag_pattern = $include_flag_pattern . $include_flag;
 }
 $include_flag_pattern = $include_flag_pattern . "]";
 # clean up if empty
@@ -1122,92 +1115,91 @@ $include_flag_pattern =~ s/^\[\]$//;
 
 
 if ($exclude_flag_pattern) {
-       my $found = 0;
-       for $pr_flag_value (@pr_flag_value) {
-               if ($exclude_flag_pattern =~ m/$pr_flag_value/) {
-                       $found = 1;
-               }
-       }
-       if (!$found) {
-               &cmd_line_err("invalid value for FLAG in --exclude-flag\n");
-               exit 1
-       }
+	my $found = 0;
+	for $pr_flag_value (@pr_flag_value) {
+		if ($exclude_flag_pattern =~ m/$pr_flag_value/) {
+			$found = 1;
+		}
+	}
+	if (!$found) {
+		&cmd_line_err("invalid value for FLAG in --exclude-flag\n");
+		exit 1
+	}
 }
 
 if ($include_flag_pattern) {
-       my $found = 0;
-       for $pr_flag_value (@pr_flag_value) {
-               if ($include_flag_pattern =~ m/$pr_flag_value/) {
-                       $found = 1;
-               }
-       }
-       if (!$found) {
-               &cmd_line_err("invalid value for FLAG in --include-flag\n");
-               exit 1
-       }
+	my $found = 0;
+	for $pr_flag_value (@pr_flag_value) {
+		if ($include_flag_pattern =~ m/$pr_flag_value/) {
+			$found = 1;
+		}
+	}
+	if (!$found) {
+		&cmd_line_err("invalid value for FLAG in --include-flag\n");
+		exit 1
+	}
 }
 
 if ($include_suspect) {
-       $include_flag_pattern =~ s/\[//;
-       $include_flag_pattern =~ s/\]//;
-       $include_flag_pattern = "[" . $include_flag_pattern . "A-Z]";
+	$include_flag_pattern =~ s/\[//;
+	$include_flag_pattern =~ s/\]//;
+	$include_flag_pattern = "[" . $include_flag_pattern . "A-Z]";
 }
 
 if ($exclude_flag_pattern =~ m/$include_flag_pattern/) {
-       &cmd_line_err("the same flag appears in both --exclude-flag and --include-flag or --include-suspect\n");
-       exit 1
+	&cmd_line_err("the same flag appears in both --exclude-flag and --include-flag or --include-suspect\n");
+	exit 1
 }
 
 
 # ($#ARGV < 0) is valid for --help, --version
 if ($#ARGV < 0) {
-       &cmd_line_err("device-tree... is required");
-       exit 1
+	&cmd_line_err("device-tree... is required");
+	exit 1
 }
 
 
 if ($config_file) {
-       &read_config_file();
+	&read_config_file();
 }
 
 
 # avoid pushing duplicates for this value
 $driver = "hardcoded_no_driver";
 for $config ( @{ $driver_config_hard_code_list{$driver} } ) {
-       push @{ $driver_config{$driver} }, $config;
+	push @{ $driver_config{$driver} }, $config;
 }
 
 if ($white_list_driver) {
-       for my $compat (keys %driver_hard_code_list) {
-               for my $driver (@{ $driver_hard_code_list{$compat} }) {
-                       push @{ $compat_driver{$compat} }, $driver;
-                       if ($driver ne "hardcoded_no_driver") {
-                               $driver_count{$compat} = scalar @{ $compat_driver{$compat} };
-                       }
-               }
-       }
+	for my $compat (keys %driver_hard_code_list) {
+		for my $driver (@{ $driver_hard_code_list{$compat} }) {
+			push @{ $compat_driver{$compat} }, $driver;
+			if ($driver ne "hardcoded_no_driver") {
+				$driver_count{$compat} = scalar @{ $compat_driver{$compat} };
+			}
+		}
+	}
 }
 
 if ($white_list_config) {
-       for my $driver (keys %driver_config_hard_code_list) {
-               if ($driver ne "hardcoded_no_driver") {
-                       for $config ( @{ $driver_config_hard_code_list{$driver} } ) {
-                               push @{ $driver_config{$driver} }, $config;
-                       }
-               }
-       }
+	for my $driver (keys %driver_config_hard_code_list) {
+		if ($driver ne "hardcoded_no_driver") {
+			for $config ( @{ $driver_config_hard_code_list{$driver} } ) {
+				push @{ $driver_config{$driver} }, $config;
+			}
+		}
+	}
 }
 
 if (-x "scripts/dtc/dtx_diff") {
-       $dtx_diff = "scripts/dtc/dtx_diff";
+	$dtx_diff = "scripts/dtc/dtx_diff";
 } else {
-
-       print STDERR "\n";
-       print STDERR "$script_name must be run from the root directory of a Linux kernel tree\n";
-       print STDERR "\n";
-       exit 3;
+	print STDERR "\n";
+	print STDERR "$script_name must be run from the root directory of a Linux kernel tree\n";
+	print STDERR "\n";
+	exit 3;
 }
 
 for $file (@ARGV) {
-       &read_dts($file);
+	&read_dts($file);
 }
-- 
2.34.1

