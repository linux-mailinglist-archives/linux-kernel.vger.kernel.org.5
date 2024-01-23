Return-Path: <linux-kernel+bounces-35528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811FB83927E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F7A1C22E24
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E6B5FEF9;
	Tue, 23 Jan 2024 15:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IWkmjfpC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B145FDC2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023187; cv=none; b=Yg0gXLMshutT1gs6bFkIUB4r3KjGLLGMnKnfYyE6BDx+vQO8M9OfybaSnlHyoUWqcD09+urH19lnSuGPbubAlmqrRyk17yCP8mVqho5cK0acXEhNE085OaeVR2bmlFYVyrbgTtaE+deB27/KB2ZbjSCiFjyfA8VG0gRbgiBtLvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023187; c=relaxed/simple;
	bh=NF+mz2jKLiduR6BZaLTs8VgCi20RB059mZWbGjBxlIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plhCiT3NZec2j8Kr7IGU3Wuv106oMP7aOEkY89pmaRJkyDeh99zlt7RVeVMQu0dpW65ttJ8qgP28Ns/A5XS5Zl8DdqvE0OnKY9KVZQr4HxXtI1B/95EiCVMUOcf2HnHHmtfqxQ9nNlKf4+d1pqCjgfugNHftQaTdT22hSOv0zcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IWkmjfpC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706023184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AoSpFDFK44DR8MwXxh+Ac0jJE9pNgV7MZIDwRdgh1to=;
	b=IWkmjfpClaLhIxYyaYYZnHIxGd0TmtRBpPeVvC89jP3xfwLGnmJ2wrOxWuauoXUbk+cVs7
	JRZRegVAps0oomQ1UeQay9VqEl2VmL2M2ZaiocflEzcyE5V3oj18Xl+JhlOkG3zIrmNmyU
	gqRrT5A3ZXtGztx6VLOwAKL/Xh2krQ4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-iOgBQLgcNNOIdh0xEieoXA-1; Tue, 23 Jan 2024 10:19:42 -0500
X-MC-Unique: iOgBQLgcNNOIdh0xEieoXA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40e8d72e1b3so45545945e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:19:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706023181; x=1706627981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AoSpFDFK44DR8MwXxh+Ac0jJE9pNgV7MZIDwRdgh1to=;
        b=StEVA50iYMMib8tcZaNkDpd/QhdBDH0WT4D1kgj1tmPf0eg2ahHS7qamqzJlmhB08J
         x+lC3AMcYlhI8JfiVqd8Xg+pWkCxPXr97BAKvCOu/rHbx0lFKSoGt/mrj4sW0SiBtaD1
         s0ZSAJ7BwZFO6tIlV1xXHQxO1aHOKz15etSupPWHUPkyBm+OlYCaYoUNETsZKmIVmwu3
         3aKh65bAY9UVBGOb95hLD9XZaWvizaEPp1G3z0NWWenH8k8lhkqTweBxi+dWv2JDgMTR
         4oCESIXK5KmR7j02eoef78WtubQYjz4BV+dwQ5QzgjVNIb5r6p8w4KLki3SnbcAKpRWE
         iOug==
X-Gm-Message-State: AOJu0YzU0buohJNjgTpnTHDvGdbctYMMMzM+0Kv9s/p5T3qFqGC0lJ/w
	SotTkZ2P+iPKGFmsC5eG7NomNLbEme0hDQn1eHlBH4YC2w4EzRjo2JCkP98UW6k3Q4Ktiq/aS77
	orDLT95niHkWTTHmRniezCgqmfABmxRmS3bn1G5wkFKp/sd9xQDG21n/9WxjvmMdhJEIlpQ==
X-Received: by 2002:a05:600c:4356:b0:40e:44de:d2a9 with SMTP id r22-20020a05600c435600b0040e44ded2a9mr248909wme.208.1706023180840;
        Tue, 23 Jan 2024 07:19:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFN2FU5rN6r3P/E+17g6thuqOhuaIEZugIHPWOXklwHnyZFi+dzUnRZqQO244WDRgjzGz8LIA==
X-Received: by 2002:a05:600c:4356:b0:40e:44de:d2a9 with SMTP id r22-20020a05600c435600b0040e44ded2a9mr248899wme.208.1706023180325;
        Tue, 23 Jan 2024 07:19:40 -0800 (PST)
Received: from redhat.com ([2.52.15.165])
        by smtp.gmail.com with ESMTPSA id h5-20020a05600c314500b0040d7c3d5454sm46737741wmo.3.2024.01.23.07.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:19:39 -0800 (PST)
Date: Tue, 23 Jan 2024 10:19:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@sberdevices.ru,
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v2] vsock/test: add '--peer-port' input argument
Message-ID: <20240123101913-mutt-send-email-mst@kernel.org>
References: <20240123072750.4084181-1-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123072750.4084181-1-avkrasnov@salutedevices.com>

On Tue, Jan 23, 2024 at 10:27:50AM +0300, Arseniy Krasnov wrote:
> Implement port for given CID as input argument instead of using
> hardcoded value '1234'. This allows to run different test instances
> on a single CID. Port argument is not required parameter and if it is
> not set, then default value will be '1234' - thus we preserve previous
> behaviour.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  Changelog:
>  v1 -> v2:
>   * Reword usage message.
>   * Add commas after last field in 'opts' declaration.
>   * 'RFC' -> 'net-next'.
> 
>  tools/testing/vsock/util.c                |  17 +++-
>  tools/testing/vsock/util.h                |   4 +
>  tools/testing/vsock/vsock_diag_test.c     |  21 +++--
>  tools/testing/vsock/vsock_test.c          | 102 +++++++++++++---------
>  tools/testing/vsock/vsock_test_zerocopy.c |  12 +--
>  tools/testing/vsock/vsock_uring_test.c    |  17 +++-
>  6 files changed, 115 insertions(+), 58 deletions(-)
> 
> diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
> index ae2b33c21c45..554b290fefdc 100644
> --- a/tools/testing/vsock/util.c
> +++ b/tools/testing/vsock/util.c
> @@ -33,8 +33,7 @@ void init_signals(void)
>  	signal(SIGPIPE, SIG_IGN);
>  }
>  
> -/* Parse a CID in string representation */
> -unsigned int parse_cid(const char *str)
> +static unsigned int parse_uint(const char *str, const char *err_str)
>  {
>  	char *endptr = NULL;
>  	unsigned long n;
> @@ -42,12 +41,24 @@ unsigned int parse_cid(const char *str)
>  	errno = 0;
>  	n = strtoul(str, &endptr, 10);
>  	if (errno || *endptr != '\0') {
> -		fprintf(stderr, "malformed CID \"%s\"\n", str);
> +		fprintf(stderr, "malformed %s \"%s\"\n", err_str, str);
>  		exit(EXIT_FAILURE);
>  	}
>  	return n;
>  }
>  
> +/* Parse a CID in string representation */
> +unsigned int parse_cid(const char *str)
> +{
> +	return parse_uint(str, "CID");
> +}
> +
> +/* Parse a port in string representation */
> +unsigned int parse_port(const char *str)
> +{
> +	return parse_uint(str, "port");
> +}
> +
>  /* Wait for the remote to close the connection */
>  void vsock_wait_remote_close(int fd)
>  {
> diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
> index 03c88d0cb861..e95e62485959 100644
> --- a/tools/testing/vsock/util.h
> +++ b/tools/testing/vsock/util.h
> @@ -12,10 +12,13 @@ enum test_mode {
>  	TEST_MODE_SERVER
>  };
>  
> +#define DEFAULT_PEER_PORT	1234
> +
>  /* Test runner options */
>  struct test_opts {
>  	enum test_mode mode;
>  	unsigned int peer_cid;
> +	unsigned int peer_port;
>  };
>  
>  /* A test case definition.  Test functions must print failures to stderr and
> @@ -35,6 +38,7 @@ struct test_case {
>  
>  void init_signals(void);
>  unsigned int parse_cid(const char *str);
> +unsigned int parse_port(const char *str);
>  int vsock_stream_connect(unsigned int cid, unsigned int port);
>  int vsock_bind_connect(unsigned int cid, unsigned int port,
>  		       unsigned int bind_port, int type);
> diff --git a/tools/testing/vsock/vsock_diag_test.c b/tools/testing/vsock/vsock_diag_test.c
> index fa927ad16f8a..9d61b1f1c4c3 100644
> --- a/tools/testing/vsock/vsock_diag_test.c
> +++ b/tools/testing/vsock/vsock_diag_test.c
> @@ -342,7 +342,7 @@ static void test_listen_socket_server(const struct test_opts *opts)
>  	} addr = {
>  		.svm = {
>  			.svm_family = AF_VSOCK,
> -			.svm_port = 1234,
> +			.svm_port = opts->peer_port,
>  			.svm_cid = VMADDR_CID_ANY,
>  		},
>  	};
> @@ -378,7 +378,7 @@ static void test_connect_client(const struct test_opts *opts)
>  	LIST_HEAD(sockets);
>  	struct vsock_stat *st;
>  
> -	fd = vsock_stream_connect(opts->peer_cid, 1234);
> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>  	if (fd < 0) {
>  		perror("connect");
>  		exit(EXIT_FAILURE);
> @@ -403,7 +403,7 @@ static void test_connect_server(const struct test_opts *opts)
>  	LIST_HEAD(sockets);
>  	int client_fd;
>  
> -	client_fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
> +	client_fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>  	if (client_fd < 0) {
>  		perror("accept");
>  		exit(EXIT_FAILURE);
> @@ -461,6 +461,11 @@ static const struct option longopts[] = {
>  		.has_arg = required_argument,
>  		.val = 'p',
>  	},
> +	{
> +		.name = "peer-port",
> +		.has_arg = required_argument,
> +		.val = 'q',
> +	},
>  	{
>  		.name = "list",
>  		.has_arg = no_argument,
> @@ -481,7 +486,7 @@ static const struct option longopts[] = {
>  
>  static void usage(void)
>  {
> -	fprintf(stderr, "Usage: vsock_diag_test [--help] [--control-host=<host>] --control-port=<port> --mode=client|server --peer-cid=<cid> [--list] [--skip=<test_id>]\n"
> +	fprintf(stderr, "Usage: vsock_diag_test [--help] [--control-host=<host>] --control-port=<port> --mode=client|server --peer-cid=<cid> [--peer-port=<port>] [--list] [--skip=<test_id>]\n"
>  		"\n"
>  		"  Server: vsock_diag_test --control-port=1234 --mode=server --peer-cid=3\n"
>  		"  Client: vsock_diag_test --control-host=192.168.0.1 --control-port=1234 --mode=client --peer-cid=2\n"
> @@ -503,9 +508,11 @@ static void usage(void)
>  		"  --control-port <port>  Server port to listen on/connect to\n"
>  		"  --mode client|server   Server or client mode\n"
>  		"  --peer-cid <cid>       CID of the other side\n"
> +		"  --peer-port <port>     AF_VSOCK port used for the test [default: %d]\n"
>  		"  --list                 List of tests that will be executed\n"
>  		"  --skip <test_id>       Test ID to skip;\n"
> -		"                         use multiple --skip options to skip more tests\n"
> +		"                         use multiple --skip options to skip more tests\n",
> +		DEFAULT_PEER_PORT
>  		);
>  	exit(EXIT_FAILURE);
>  }
> @@ -517,6 +524,7 @@ int main(int argc, char **argv)
>  	struct test_opts opts = {
>  		.mode = TEST_MODE_UNSET,
>  		.peer_cid = VMADDR_CID_ANY,
> +		.peer_port = DEFAULT_PEER_PORT,
>  	};
>  
>  	init_signals();
> @@ -544,6 +552,9 @@ int main(int argc, char **argv)
>  		case 'p':
>  			opts.peer_cid = parse_cid(optarg);
>  			break;
> +		case 'q':
> +			opts.peer_port = parse_port(optarg);
> +			break;
>  		case 'P':
>  			control_port = optarg;
>  			break;
> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
> index 66246d81d654..f851f8961247 100644
> --- a/tools/testing/vsock/vsock_test.c
> +++ b/tools/testing/vsock/vsock_test.c
> @@ -34,7 +34,7 @@ static void test_stream_connection_reset(const struct test_opts *opts)
>  	} addr = {
>  		.svm = {
>  			.svm_family = AF_VSOCK,
> -			.svm_port = 1234,
> +			.svm_port = opts->peer_port,
>  			.svm_cid = opts->peer_cid,
>  		},
>  	};
> @@ -70,7 +70,7 @@ static void test_stream_bind_only_client(const struct test_opts *opts)
>  	} addr = {
>  		.svm = {
>  			.svm_family = AF_VSOCK,
> -			.svm_port = 1234,
> +			.svm_port = opts->peer_port,
>  			.svm_cid = opts->peer_cid,
>  		},
>  	};
> @@ -112,7 +112,7 @@ static void test_stream_bind_only_server(const struct test_opts *opts)
>  	} addr = {
>  		.svm = {
>  			.svm_family = AF_VSOCK,
> -			.svm_port = 1234,
> +			.svm_port = opts->peer_port,
>  			.svm_cid = VMADDR_CID_ANY,
>  		},
>  	};
> @@ -138,7 +138,7 @@ static void test_stream_client_close_client(const struct test_opts *opts)
>  {
>  	int fd;
>  
> -	fd = vsock_stream_connect(opts->peer_cid, 1234);
> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>  	if (fd < 0) {
>  		perror("connect");
>  		exit(EXIT_FAILURE);
> @@ -152,7 +152,7 @@ static void test_stream_client_close_server(const struct test_opts *opts)
>  {
>  	int fd;
>  
> -	fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
> +	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>  	if (fd < 0) {
>  		perror("accept");
>  		exit(EXIT_FAILURE);
> @@ -173,7 +173,7 @@ static void test_stream_server_close_client(const struct test_opts *opts)
>  {
>  	int fd;
>  
> -	fd = vsock_stream_connect(opts->peer_cid, 1234);
> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>  	if (fd < 0) {
>  		perror("connect");
>  		exit(EXIT_FAILURE);
> @@ -194,7 +194,7 @@ static void test_stream_server_close_server(const struct test_opts *opts)
>  {
>  	int fd;
>  
> -	fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
> +	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>  	if (fd < 0) {
>  		perror("accept");
>  		exit(EXIT_FAILURE);
> @@ -215,7 +215,7 @@ static void test_stream_multiconn_client(const struct test_opts *opts)
>  	int i;
>  
>  	for (i = 0; i < MULTICONN_NFDS; i++) {
> -		fds[i] = vsock_stream_connect(opts->peer_cid, 1234);
> +		fds[i] = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>  		if (fds[i] < 0) {
>  			perror("connect");
>  			exit(EXIT_FAILURE);
> @@ -239,7 +239,7 @@ static void test_stream_multiconn_server(const struct test_opts *opts)
>  	int i;
>  
>  	for (i = 0; i < MULTICONN_NFDS; i++) {
> -		fds[i] = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
> +		fds[i] = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>  		if (fds[i] < 0) {
>  			perror("accept");
>  			exit(EXIT_FAILURE);
> @@ -267,9 +267,9 @@ static void test_msg_peek_client(const struct test_opts *opts,
>  	int i;
>  
>  	if (seqpacket)
> -		fd = vsock_seqpacket_connect(opts->peer_cid, 1234);
> +		fd = vsock_seqpacket_connect(opts->peer_cid, opts->peer_port);
>  	else
> -		fd = vsock_stream_connect(opts->peer_cid, 1234);
> +		fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>  
>  	if (fd < 0) {
>  		perror("connect");
> @@ -295,9 +295,9 @@ static void test_msg_peek_server(const struct test_opts *opts,
>  	int fd;
>  
>  	if (seqpacket)
> -		fd = vsock_seqpacket_accept(VMADDR_CID_ANY, 1234, NULL);
> +		fd = vsock_seqpacket_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>  	else
> -		fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
> +		fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>  
>  	if (fd < 0) {
>  		perror("accept");
> @@ -363,7 +363,7 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
>  	int msg_count;
>  	int fd;
>  
> -	fd = vsock_seqpacket_connect(opts->peer_cid, 1234);
> +	fd = vsock_seqpacket_connect(opts->peer_cid, opts->peer_port);
>  	if (fd < 0) {
>  		perror("connect");
>  		exit(EXIT_FAILURE);
> @@ -434,7 +434,7 @@ static void test_seqpacket_msg_bounds_server(const struct test_opts *opts)
>  	struct msghdr msg = {0};
>  	struct iovec iov = {0};
>  
> -	fd = vsock_seqpacket_accept(VMADDR_CID_ANY, 1234, NULL);
> +	fd = vsock_seqpacket_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>  	if (fd < 0) {
>  		perror("accept");
>  		exit(EXIT_FAILURE);
> @@ -505,7 +505,7 @@ static void test_seqpacket_msg_trunc_client(const struct test_opts *opts)
>  	int fd;
>  	char buf[MESSAGE_TRUNC_SZ];
>  
> -	fd = vsock_seqpacket_connect(opts->peer_cid, 1234);
> +	fd = vsock_seqpacket_connect(opts->peer_cid, opts->peer_port);
>  	if (fd < 0) {
>  		perror("connect");
>  		exit(EXIT_FAILURE);
> @@ -524,7 +524,7 @@ static void test_seqpacket_msg_trunc_server(const struct test_opts *opts)
>  	struct msghdr msg = {0};
>  	struct iovec iov = {0};
>  
> -	fd = vsock_seqpacket_accept(VMADDR_CID_ANY, 1234, NULL);
> +	fd = vsock_seqpacket_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>  	if (fd < 0) {
>  		perror("accept");
>  		exit(EXIT_FAILURE);
> @@ -575,7 +575,7 @@ static void test_seqpacket_timeout_client(const struct test_opts *opts)
>  	time_t read_enter_ns;
>  	time_t read_overhead_ns;
>  
> -	fd = vsock_seqpacket_connect(opts->peer_cid, 1234);
> +	fd = vsock_seqpacket_connect(opts->peer_cid, opts->peer_port);
>  	if (fd < 0) {
>  		perror("connect");
>  		exit(EXIT_FAILURE);
> @@ -620,7 +620,7 @@ static void test_seqpacket_timeout_server(const struct test_opts *opts)
>  {
>  	int fd;
>  
> -	fd = vsock_seqpacket_accept(VMADDR_CID_ANY, 1234, NULL);
> +	fd = vsock_seqpacket_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>  	if (fd < 0) {
>  		perror("accept");
>  		exit(EXIT_FAILURE);
> @@ -639,7 +639,7 @@ static void test_seqpacket_bigmsg_client(const struct test_opts *opts)
>  
>  	len = sizeof(sock_buf_size);
>  
> -	fd = vsock_seqpacket_connect(opts->peer_cid, 1234);
> +	fd = vsock_seqpacket_connect(opts->peer_cid, opts->peer_port);
>  	if (fd < 0) {
>  		perror("connect");
>  		exit(EXIT_FAILURE);
> @@ -671,7 +671,7 @@ static void test_seqpacket_bigmsg_server(const struct test_opts *opts)
>  {
>  	int fd;
>  
> -	fd = vsock_seqpacket_accept(VMADDR_CID_ANY, 1234, NULL);
> +	fd = vsock_seqpacket_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>  	if (fd < 0) {
>  		perror("accept");
>  		exit(EXIT_FAILURE);
> @@ -692,7 +692,7 @@ static void test_seqpacket_invalid_rec_buffer_client(const struct test_opts *opt
>  	unsigned char *buf2;
>  	int buf_size = getpagesize() * 3;
>  
> -	fd = vsock_seqpacket_connect(opts->peer_cid, 1234);
> +	fd = vsock_seqpacket_connect(opts->peer_cid, opts->peer_port);
>  	if (fd < 0) {
>  		perror("connect");
>  		exit(EXIT_FAILURE);
> @@ -732,7 +732,7 @@ static void test_seqpacket_invalid_rec_buffer_server(const struct test_opts *opt
>  	int flags = MAP_PRIVATE | MAP_ANONYMOUS;
>  	int i;
>  
> -	fd = vsock_seqpacket_accept(VMADDR_CID_ANY, 1234, NULL);
> +	fd = vsock_seqpacket_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>  	if (fd < 0) {
>  		perror("accept");
>  		exit(EXIT_FAILURE);
> @@ -808,7 +808,7 @@ static void test_stream_poll_rcvlowat_server(const struct test_opts *opts)
>  	int fd;
>  	int i;
>  
> -	fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
> +	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>  	if (fd < 0) {
>  		perror("accept");
>  		exit(EXIT_FAILURE);
> @@ -839,7 +839,7 @@ static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
>  	short poll_flags;
>  	int fd;
>  
> -	fd = vsock_stream_connect(opts->peer_cid, 1234);
> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>  	if (fd < 0) {
>  		perror("connect");
>  		exit(EXIT_FAILURE);
> @@ -906,9 +906,9 @@ static void test_inv_buf_client(const struct test_opts *opts, bool stream)
>  	int fd;
>  
>  	if (stream)
> -		fd = vsock_stream_connect(opts->peer_cid, 1234);
> +		fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>  	else
> -		fd = vsock_seqpacket_connect(opts->peer_cid, 1234);
> +		fd = vsock_seqpacket_connect(opts->peer_cid, opts->peer_port);
>  
>  	if (fd < 0) {
>  		perror("connect");
> @@ -941,9 +941,9 @@ static void test_inv_buf_server(const struct test_opts *opts, bool stream)
>  	int fd;
>  
>  	if (stream)
> -		fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
> +		fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>  	else
> -		fd = vsock_seqpacket_accept(VMADDR_CID_ANY, 1234, NULL);
> +		fd = vsock_seqpacket_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>  
>  	if (fd < 0) {
>  		perror("accept");
> @@ -986,7 +986,7 @@ static void test_stream_virtio_skb_merge_client(const struct test_opts *opts)
>  {
>  	int fd;
>  
> -	fd = vsock_stream_connect(opts->peer_cid, 1234);
> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>  	if (fd < 0) {
>  		perror("connect");
>  		exit(EXIT_FAILURE);
> @@ -1015,7 +1015,7 @@ static void test_stream_virtio_skb_merge_server(const struct test_opts *opts)
>  	unsigned char buf[64];
>  	int fd;
>  
> -	fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
> +	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>  	if (fd < 0) {
>  		perror("accept");
>  		exit(EXIT_FAILURE);
> @@ -1108,7 +1108,7 @@ static void test_stream_shutwr_client(const struct test_opts *opts)
>  
>  	sigaction(SIGPIPE, &act, NULL);
>  
> -	fd = vsock_stream_connect(opts->peer_cid, 1234);
> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>  	if (fd < 0) {
>  		perror("connect");
>  		exit(EXIT_FAILURE);
> @@ -1130,7 +1130,7 @@ static void test_stream_shutwr_server(const struct test_opts *opts)
>  {
>  	int fd;
>  
> -	fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
> +	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>  	if (fd < 0) {
>  		perror("accept");
>  		exit(EXIT_FAILURE);
> @@ -1151,7 +1151,7 @@ static void test_stream_shutrd_client(const struct test_opts *opts)
>  
>  	sigaction(SIGPIPE, &act, NULL);
>  
> -	fd = vsock_stream_connect(opts->peer_cid, 1234);
> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>  	if (fd < 0) {
>  		perror("connect");
>  		exit(EXIT_FAILURE);
> @@ -1170,7 +1170,7 @@ static void test_stream_shutrd_server(const struct test_opts *opts)
>  {
>  	int fd;
>  
> -	fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
> +	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>  	if (fd < 0) {
>  		perror("accept");
>  		exit(EXIT_FAILURE);
> @@ -1193,7 +1193,7 @@ static void test_double_bind_connect_server(const struct test_opts *opts)
>  	struct sockaddr_vm sa_client;
>  	socklen_t socklen_client = sizeof(sa_client);
>  
> -	listen_fd = vsock_stream_listen(VMADDR_CID_ANY, 1234);
> +	listen_fd = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
>  
>  	for (i = 0; i < 2; i++) {
>  		control_writeln("LISTENING");
> @@ -1226,7 +1226,13 @@ static void test_double_bind_connect_client(const struct test_opts *opts)
>  		/* Wait until server is ready to accept a new connection */
>  		control_expectln("LISTENING");
>  
> -		client_fd = vsock_bind_connect(opts->peer_cid, 1234, 4321, SOCK_STREAM);
> +		/* We use 'peer_port + 1' as "some" port for the 'bind()'
> +		 * call. It is safe for overflow, but must be considered,
> +		 * when running multiple test applications simultaneously
> +		 * where 'peer-port' argument differs by 1.
> +		 */
> +		client_fd = vsock_bind_connect(opts->peer_cid, opts->peer_port,
> +					       opts->peer_port + 1, SOCK_STREAM);
>  
>  		close(client_fd);
>  	}
> @@ -1246,7 +1252,7 @@ static void test_stream_rcvlowat_def_cred_upd_client(const struct test_opts *opt
>  	void *buf;
>  	int fd;
>  
> -	fd = vsock_stream_connect(opts->peer_cid, 1234);
> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>  	if (fd < 0) {
>  		perror("connect");
>  		exit(EXIT_FAILURE);
> @@ -1282,7 +1288,7 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
>  	void *buf;
>  	int fd;
>  
> -	fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
> +	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>  	if (fd < 0) {
>  		perror("accept");
>  		exit(EXIT_FAILURE);
> @@ -1542,6 +1548,11 @@ static const struct option longopts[] = {
>  		.has_arg = required_argument,
>  		.val = 'p',
>  	},
> +	{
> +		.name = "peer-port",
> +		.has_arg = required_argument,
> +		.val = 'q',
> +	},
>  	{
>  		.name = "list",
>  		.has_arg = no_argument,
> @@ -1562,7 +1573,7 @@ static const struct option longopts[] = {
>  
>  static void usage(void)
>  {
> -	fprintf(stderr, "Usage: vsock_test [--help] [--control-host=<host>] --control-port=<port> --mode=client|server --peer-cid=<cid> [--list] [--skip=<test_id>]\n"
> +	fprintf(stderr, "Usage: vsock_test [--help] [--control-host=<host>] --control-port=<port> --mode=client|server --peer-cid=<cid> [--peer-port=<port>] [--list] [--skip=<test_id>]\n"
>  		"\n"
>  		"  Server: vsock_test --control-port=1234 --mode=server --peer-cid=3\n"
>  		"  Client: vsock_test --control-host=192.168.0.1 --control-port=1234 --mode=client --peer-cid=2\n"
> @@ -1577,6 +1588,9 @@ static void usage(void)
>  		"connect to.\n"
>  		"\n"
>  		"The CID of the other side must be given with --peer-cid=<cid>.\n"
> +		"During the test, two AF_VSOCK ports will be used: the port\n"
> +		"specified with --peer-port=<port> (or the default port)\n"
> +		"and the next one.\n"
>  		"\n"
>  		"Options:\n"
>  		"  --help                 This help message\n"
> @@ -1584,9 +1598,11 @@ static void usage(void)
>  		"  --control-port <port>  Server port to listen on/connect to\n"
>  		"  --mode client|server   Server or client mode\n"
>  		"  --peer-cid <cid>       CID of the other side\n"
> +		"  --peer-port <port>     AF_VSOCK port used for the test [default: %d]\n"
>  		"  --list                 List of tests that will be executed\n"
>  		"  --skip <test_id>       Test ID to skip;\n"
> -		"                         use multiple --skip options to skip more tests\n"
> +		"                         use multiple --skip options to skip more tests\n",
> +		DEFAULT_PEER_PORT
>  		);
>  	exit(EXIT_FAILURE);
>  }
> @@ -1598,6 +1614,7 @@ int main(int argc, char **argv)
>  	struct test_opts opts = {
>  		.mode = TEST_MODE_UNSET,
>  		.peer_cid = VMADDR_CID_ANY,
> +		.peer_port = DEFAULT_PEER_PORT,
>  	};
>  
>  	srand(time(NULL));
> @@ -1626,6 +1643,9 @@ int main(int argc, char **argv)
>  		case 'p':
>  			opts.peer_cid = parse_cid(optarg);
>  			break;
> +		case 'q':
> +			opts.peer_port = parse_port(optarg);
> +			break;
>  		case 'P':
>  			control_port = optarg;
>  			break;
> diff --git a/tools/testing/vsock/vsock_test_zerocopy.c b/tools/testing/vsock/vsock_test_zerocopy.c
> index a16ff76484e6..04c376b6937f 100644
> --- a/tools/testing/vsock/vsock_test_zerocopy.c
> +++ b/tools/testing/vsock/vsock_test_zerocopy.c
> @@ -152,9 +152,9 @@ static void test_client(const struct test_opts *opts,
>  	int fd;
>  
>  	if (sock_seqpacket)
> -		fd = vsock_seqpacket_connect(opts->peer_cid, 1234);
> +		fd = vsock_seqpacket_connect(opts->peer_cid, opts->peer_port);
>  	else
> -		fd = vsock_stream_connect(opts->peer_cid, 1234);
> +		fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>  
>  	if (fd < 0) {
>  		perror("connect");
> @@ -248,9 +248,9 @@ static void test_server(const struct test_opts *opts,
>  	int fd;
>  
>  	if (sock_seqpacket)
> -		fd = vsock_seqpacket_accept(VMADDR_CID_ANY, 1234, NULL);
> +		fd = vsock_seqpacket_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>  	else
> -		fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
> +		fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>  
>  	if (fd < 0) {
>  		perror("accept");
> @@ -323,7 +323,7 @@ void test_stream_msgzcopy_empty_errq_client(const struct test_opts *opts)
>  	ssize_t res;
>  	int fd;
>  
> -	fd = vsock_stream_connect(opts->peer_cid, 1234);
> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>  	if (fd < 0) {
>  		perror("connect");
>  		exit(EXIT_FAILURE);
> @@ -347,7 +347,7 @@ void test_stream_msgzcopy_empty_errq_server(const struct test_opts *opts)
>  {
>  	int fd;
>  
> -	fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
> +	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>  	if (fd < 0) {
>  		perror("accept");
>  		exit(EXIT_FAILURE);
> diff --git a/tools/testing/vsock/vsock_uring_test.c b/tools/testing/vsock/vsock_uring_test.c
> index d976d35f0ba9..6c3e6f70c457 100644
> --- a/tools/testing/vsock/vsock_uring_test.c
> +++ b/tools/testing/vsock/vsock_uring_test.c
> @@ -66,7 +66,7 @@ static void vsock_io_uring_client(const struct test_opts *opts,
>  	struct msghdr msg;
>  	int fd;
>  
> -	fd = vsock_stream_connect(opts->peer_cid, 1234);
> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>  	if (fd < 0) {
>  		perror("connect");
>  		exit(EXIT_FAILURE);
> @@ -120,7 +120,7 @@ static void vsock_io_uring_server(const struct test_opts *opts,
>  	void *data;
>  	int fd;
>  
> -	fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
> +	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>  	if (fd < 0) {
>  		perror("accept");
>  		exit(EXIT_FAILURE);
> @@ -247,6 +247,11 @@ static const struct option longopts[] = {
>  		.has_arg = required_argument,
>  		.val = 'p',
>  	},
> +	{
> +		.name = "peer-port",
> +		.has_arg = required_argument,
> +		.val = 'q',
> +	},
>  	{
>  		.name = "help",
>  		.has_arg = no_argument,
> @@ -257,7 +262,7 @@ static const struct option longopts[] = {
>  
>  static void usage(void)
>  {
> -	fprintf(stderr, "Usage: vsock_uring_test [--help] [--control-host=<host>] --control-port=<port> --mode=client|server --peer-cid=<cid>\n"
> +	fprintf(stderr, "Usage: vsock_uring_test [--help] [--control-host=<host>] --control-port=<port> --mode=client|server --peer-cid=<cid> [--peer-port=<port>]\n"
>  		"\n"
>  		"  Server: vsock_uring_test --control-port=1234 --mode=server --peer-cid=3\n"
>  		"  Client: vsock_uring_test --control-host=192.168.0.1 --control-port=1234 --mode=client --peer-cid=2\n"
> @@ -271,6 +276,8 @@ static void usage(void)
>  		"  --control-port <port>  Server port to listen on/connect to\n"
>  		"  --mode client|server   Server or client mode\n"
>  		"  --peer-cid <cid>       CID of the other side\n"
> +		"  --peer-port <port>     AF_VSOCK port used for the test [default: %d]\n",
> +		DEFAULT_PEER_PORT
>  		);
>  	exit(EXIT_FAILURE);
>  }
> @@ -282,6 +289,7 @@ int main(int argc, char **argv)
>  	struct test_opts opts = {
>  		.mode = TEST_MODE_UNSET,
>  		.peer_cid = VMADDR_CID_ANY,
> +		.peer_port = DEFAULT_PEER_PORT,
>  	};
>  
>  	init_signals();
> @@ -309,6 +317,9 @@ int main(int argc, char **argv)
>  		case 'p':
>  			opts.peer_cid = parse_cid(optarg);
>  			break;
> +		case 'q':
> +			opts.peer_port = parse_port(optarg);
> +			break;
>  		case 'P':
>  			control_port = optarg;
>  			break;
> -- 
> 2.25.1


