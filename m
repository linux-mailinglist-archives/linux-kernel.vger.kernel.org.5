Return-Path: <linux-kernel+bounces-77435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BDF860552
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20CB01C22CE7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B2F137930;
	Thu, 22 Feb 2024 22:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZhiddbWa"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC48612D21C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 22:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708639260; cv=none; b=LV1uc5aoCLxkOTZ5e5elRJvnsvjY/ry8IGDX9pSuhnPOAaf8J0DIB5ED6ojGHJ3fKrEmexxnwKjH6d2U5SSWmZ91ZpAeVeDa8GCjzBpZQO+X3awZNZ5d0WKNqZxOxG20I9zhGgGU1jhtpbJono98yDxsdYbwzDoTJWK6I8GgtTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708639260; c=relaxed/simple;
	bh=ZM2GR6IBtwz0kQ9xgCjrTuxbIaOuzN6JpSMqdXS7f9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BaY2JTJ51CmnMlMvPk4S40bC91DD1I1+eqRyp2byRvBn9Cl39jM05/r51hWtJ64fEU8O0I5EZ0saP5Ie7s4DXNUag8qOJ13lmCjEymrkOQ00v9130MPpS3WBm/gon3BQClqmr4Cd80Fu387AnkKaTFqAqA4QZguSYXxafHgO8ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZhiddbWa; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dc1ff58fe4so2780495ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708639255; x=1709244055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xe2gLkj39s2Uoixf+agRWlsso1N0pC35kqHZ8X47pOU=;
        b=ZhiddbWahVMWtvB/rz/K+UZHACbjzHHGxkuQFvwrLlK/goGZmLWHuuZb0QODgXUUM8
         M3860+sM4Vhfa39xhF/lw9tcJvFVRiuHjjZ8MMampG6zh3JpLSdlYbqVsuFdvr43o3L2
         u9SW0ydQziNCrbawdW7hlYKjrvPVw/sX8hWRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708639255; x=1709244055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xe2gLkj39s2Uoixf+agRWlsso1N0pC35kqHZ8X47pOU=;
        b=jUfkdJsbWyu0IZYlJvxG6VPpP6XxRIFLS1hcZA+NgjU8glSW1eyiV6oOvZa3iNyl84
         tcTbRE63n5Bvh6vr+4lHet/Ws7T7j8XbkcPiY3G2HZ+W+9cOGLsbANoW8rrx7ajECASW
         0Ietg8ShFiZHRGDxCa0WI2Wspt0Ld22jdPQvB8Thm8pU375n4pmRnl+gpzvtX8ec28wj
         RjZL+vc2RH3o40ARp7ZYP6Lm8KACmRK8uU/fIN79lzvGjNFvf0KOVWi8d9o/DsXv4kV7
         Pk4BxSH4EZe8wAvnCXO4hMGoS9+bQOetq3IMTW/KSY2vM3MrgtCKFby22zJ1YzdfeU/M
         doTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS4azMx4pQp0lTohSbiKawh+lKmBuI2eaqXNKgfRCJ+Cp04aprMTPQ1LDtBZNOBF1C+az7vC+gSHv0apvOmAmgpO3MiouWpZ5bffNk
X-Gm-Message-State: AOJu0YwjL31/4Xkr0UaeFJS4wpJz89WUQBHpiMyHTAnLIWHd43GVgYDe
	JlWilUJYjRaNPNy85vXXzani7hLxvsJ7VuOdNetAJrjE+/B2uhN02PebMNj5Fw==
X-Google-Smtp-Source: AGHT+IHLoJ6j4MLYboXYihdrpaCgY53S5xqzDgny9A2xvBVNtQjVuQKuNHqG4IUCUAX7D0T4anbODw==
X-Received: by 2002:a17:902:f690:b0:1db:e9ea:31 with SMTP id l16-20020a170902f69000b001dbe9ea0031mr136788plg.62.1708639255087;
        Thu, 22 Feb 2024 14:00:55 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q18-20020a170902c9d200b001db9d2c1874sm10441463pld.29.2024.02.22.14.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 14:00:54 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Kees Cook <keescook@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Tobin C. Harding" <me@tobin.cc>,
	Guixiong Wei <guixiongwei@gmail.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] leaking_addresses: Provide mechanism to scan binary files
Date: Thu, 22 Feb 2024 14:00:51 -0800
Message-Id: <20240222220053.1475824-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222215755.it.764-kees@kernel.org>
References: <20240222215755.it.764-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3757; i=keescook@chromium.org;
 h=from:subject; bh=ZM2GR6IBtwz0kQ9xgCjrTuxbIaOuzN6JpSMqdXS7f9k=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl18QTRS+OtPCzXuU3K6f0NRCmSrNpfZm2QSXVK
 vx4OP/dXYWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZdfEEwAKCRCJcvTf3G3A
 JnYhD/95iRSTT8PrBCec5gNuggTGafSw4zAl7bfV4degmG5Ys3xBX/fiYw7IYq9ewTeT2l6TwmC
 zN5t7qF0GMvCgFG5loC0zmyhrPmM5A/FqeuBsR02nSJgA2OMagymx4uHYclFUlDsKICsPfUKpm4
 LtA0T8KCdB9qkmf+k+yqYfP/CQDJVY8bVkegNoc7U9WbSME94EAIDXQe1yZz9F55/bwOUPtci+X
 R55bhbhgxacEm+i2299Pl5WruZ7YDAcHVYXp/tMAXowh7gGqhZYFstwIl2Cf1YKBfF31LSt4KXz
 ahC/wRGevY09cLB0cGNusBlSypdD3/i+NPRLxL3QZ+/q4CLnsq9qKitVrCzSE/xC2HqtkVasQGm
 0Ju++VXbp18k2ydPKN40po7JQp3zofvqyD0TQCAnb8wsojY9RnFhwewgKXu78tZrO0gtyZtgWwx
 tDMiAT14TNl3NBv7Omrxmx+M+8oDliUXUD3ODZqkglCggskDHkLfgO4HLQlLbvDi2SEvDsTDZip
 ZzgNKpEdBdArv7qWxf4VGELv/aSVnl+w7THW8Y/3l+pqufGutRKEfCd45podywPcuphq+SWSizr
 lNlwM/LCYVOCVAtCIJCuOdZwzd/hkpvj1WWMf8Ggc/N3xxWSTEllF5UBOtc18k7Bn8bm9TQJgTh dH5AIHLCd39ufpg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Introduce --kallsyms argument for scanning binary files for known symbol
addresses. This would have found the exposure in /sys/kernel/notes:

$ scripts/leaking_addresses.pl --kallsyms=<(sudo cat /proc/kallsyms)
/sys/kernel/notes: hypercall_page @ 156
/sys/kernel/notes: xen_hypercall_set_trap_table @ 156
/sys/kernel/notes: startup_xen @ 132

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: "Tobin C. Harding" <me@tobin.cc>
Cc: Tycho Andersen <tycho@tycho.pizza>
Cc: Guixiong Wei <guixiongwei@gmail.com>
Cc: linux-hardening@vger.kernel.org
---
 scripts/leaking_addresses.pl | 53 ++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
index 73cfcc5c8854..8e992b18bcd9 100755
--- a/scripts/leaking_addresses.pl
+++ b/scripts/leaking_addresses.pl
@@ -52,10 +52,13 @@ my $input_raw = "";	# Read raw results from file instead of scanning.
 my $suppress_dmesg = 0;		# Don't show dmesg in output.
 my $squash_by_path = 0;		# Summary report grouped by absolute path.
 my $squash_by_filename = 0;	# Summary report grouped by filename.
+my $kallsyms_file = "";		# Kernel symbols file.
 my $kernel_config_file = "";	# Kernel configuration file.
 my $opt_32bit = 0;		# Scan 32-bit kernel.
 my $page_offset_32bit = 0;	# Page offset for 32-bit kernel.
 
+my @kallsyms = ();
+
 # Skip these absolute paths.
 my @skip_abs = (
 	'/proc/kmsg',
@@ -96,6 +99,8 @@ Options:
 	      --squash-by-path		Show one result per unique path.
 	      --squash-by-filename	Show one result per unique filename.
 	--kernel-config-file=<file>     Kernel configuration file (e.g /boot/config)
+	--kallsyms=<file>		Read kernel symbol addresses from file (for
+						scanning binary files).
 	--32-bit			Scan 32-bit kernel.
 	--page-offset-32-bit=o		Page offset (for 32-bit kernel 0xABCD1234).
 	-d, --debug			Display debugging output.
@@ -116,6 +121,7 @@ GetOptions(
 	'squash-by-path'        => \$squash_by_path,
 	'squash-by-filename'    => \$squash_by_filename,
 	'raw'                   => \$raw,
+	'kallsyms=s'            => \$kallsyms_file,
 	'kernel-config-file=s'	=> \$kernel_config_file,
 	'32-bit'		=> \$opt_32bit,
 	'page-offset-32-bit=o'	=> \$page_offset_32bit,
@@ -156,6 +162,25 @@ if ($output_raw) {
 	select $fh;
 }
 
+if ($kallsyms_file) {
+	open my $fh, '<', $kallsyms_file or die "$0: $kallsyms_file: $!\n";
+	while (<$fh>) {
+		chomp;
+		my @entry = split / /, $_;
+		my $addr_text = $entry[0];
+		if ($addr_text !~ /^0/) {
+			# TODO: Why is hex() so impossibly slow?
+			my $addr = hex($addr_text);
+			my $symbol = $entry[2];
+			# Only keep kernel text addresses.
+			my $long = pack("J", $addr);
+			my $entry = [$long, $symbol];
+			push @kallsyms, $entry;
+		}
+	}
+	close $fh;
+}
+
 parse_dmesg();
 walk(@DIRS);
 
@@ -447,6 +472,25 @@ sub timed_parse_file
 	}
 }
 
+sub parse_binary
+{
+	my ($file) = @_;
+
+	open my $fh, "<:raw", $file or return;
+	local $/ = undef;
+	my $bytes = <$fh>;
+	close $fh;
+
+	foreach my $entry (@kallsyms) {
+		my $addr = $entry->[0];
+		my $symbol = $entry->[1];
+		my $offset = index($bytes, $addr);
+		if ($offset != -1) {
+			printf("$file: $symbol @ $offset\n");
+		}
+	}
+}
+
 sub parse_file
 {
 	my ($file) = @_;
@@ -456,6 +500,15 @@ sub parse_file
 	}
 
 	if (! -T $file) {
+		if ($file =~ m|^/sys/kernel/btf/| or
+		    $file =~ m|^/sys/devices/pci| or
+		    $file =~ m|^/sys/firmware/efi/efivars/| or
+		    $file =~ m|^/proc/bus/pci/|) {
+			return;
+		}
+		if (scalar @kallsyms > 0) {
+			parse_binary($file);
+		}
 		return;
 	}
 
-- 
2.34.1


